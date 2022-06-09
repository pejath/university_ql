# frozen_string_literal: true

module Sources
  module Concerns
    # Override the `batch_key_for` method so that when an ActiveRecord::Relation
    # (or any object that implements `to_sql`) is given, use the generated SQL
    # as the unique batch key.
    # Without this, even relations with identical config would be executed separately.
    #
    # https://graphql-ruby.org/api-doc/1.12.19/GraphQL/Dataloader/Source#batch_key_for-class_method
    #
    module AutoSqlBatchKey
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def batch_key_for(*batch_args, **batch_kwargs)
          source = batch_args.first

          if source.respond_to?(:to_sql)
            source.to_sql.hash
          else
            super
          end
        end
      end
    end
  end
end
