# frozen_string_literal: true

module Sources
  # Batch loads records referenced in a `has_one` or `has_many` relationship.
  # The `model_class` is the base relation for the foreign model (e.g. ::Address)
  # and the `fk` is the field or polymorphic relation that serves as the foreign key,
  # such as `:parent_id` or `:addressable`
  class ActiveRecordForeignObjects < GraphQL::Dataloader::Source
    include Concerns::AutoSqlBatchKey

    attr_reader :model_class, :fk, :options

    def initialize(model_class, fk, options = {})
      @model_class = model_class
      @fk = fk
      @options = options

      super()
    end

    def fetch(refs)
      assoc = model_class.reflect_on_association(fk)

      raise "Association '#{fk}' does not exist on #{model_class}" if assoc.nil?

      # If the relationship is polymorphic, the `foreign_type` will be present.
      # If it is, we need to make a composite record key so we get type and ID.
      # For non-polymorphic, just use the record ID.
      if (foreign_type = assoc.foreign_type)
        index_by = [foreign_type, assoc.foreign_key]
        # Convert each object into a pair of type and id, e.g. [ ["User", 1], ["Account", 2] ]
        # as hash keys, referencing the object itself (which may be needed later)
        composite_refs = refs.to_h { |ref| [[ref.model_name.name, ref.id], ref] }
      else
        index_by = [assoc.foreign_key]
        composite_refs = refs.to_h do |ref|
          id = ref.is_a?(Integer) ? ref : ref.id
          [[id], ref]
        end
      end

      scope = model_class

      opts = Sources::ActiveRecordDefaults.options_for(model_class, options)

      if (preload = opts[:preload])
        scope = scope.preload(preload)
      end

      records = scope
                  .strict_loading
                  .where(fk => refs.compact)
                  .group_by { |r| r.slice(*index_by).values }

      composite_refs.map do |key, ref|
        ref_records = records[key]

        next nil if ref_records.nil?

        if opts.fetch(:set_target, false) && ref.is_a?(::ActiveRecord::Base)
          ref_records = assign_inverse_record(ref_records, fk, ref)
        end

        ref_records
      end
    end

    private

    # When we know the parent/target of the fk, we can set it on the loaded record.
    # This allows the record to refer to the parent/target without needing to be
    # explicitly loaded. This is mostly useful for policies that reference the parent.
    def assign_inverse_record(records, assoc_name, target)
      records.map do |record|
        record.association(assoc_name).tap do |assoc_instance|
          assoc_instance.inversed_from(target)
          assoc_instance.loaded!
        end
        record
      end
    end
  end
end
