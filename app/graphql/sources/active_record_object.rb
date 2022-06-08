# frozen_string_literal: true

module Sources
  # Batch loads records for a `belongs_to` relation.
  # The `model_class` is the base relation for the foreign model, such as ::Account
  class ActiveRecordObject < GraphQL::Dataloader::Source
    include Concerns::AutoSqlBatchKey

    attr_reader :model_class, :options

    def initialize(model_class, options = {})
      @model_class = model_class
      @options = options
      super()
    end

    def fetch(ids)
      scope = model_class

      scope = Sources::ActiveRecordDefaults.apply_to(scope, options)

      records = scope.where(id: ids.compact).index_by(&:id)

      # We must return a list with the same size and order as the input `ids`,
      # and if a record isn't found for some reason, a `nil` goes in its place.
      ids.map do |id|
        records[id]
      end
    end
  end
end
