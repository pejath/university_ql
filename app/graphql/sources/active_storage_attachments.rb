# frozen_string_literal: true

module Sources
  # Batch load attachments.
  # With a refactor, this may be combinable with ActiveRecordForeignObject.
  class ActiveStorageAttachments < GraphQL::Dataloader::Source
    attr_reader :attachment_name

    def initialize(attachment_name)
      @attachment_name = attachment_name
      super()
    end

    def fetch(refs)
      # Convert each object into a pair of type and id, e.g. [ ["User", 1], ["Account", 2] ]
      composite_refs = refs.map { |ref| [ref.model_name.name, ref.id] }

      records = ::ActiveStorage::Attachment
                  .strict_loading
                  .joins(:blob)
                  .includes(:blob)
                  .where(name: attachment_name)
                  .where(record: refs.compact)
                  .group_by { |r| r.slice(:record_type, :record_id).values }

      composite_refs.map do |ref|
        records[ref]
      end
    end
  end
end
