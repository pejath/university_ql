# frozen_string_literal: true

module Types
  module Interfaces
    module Timestamps
      include Types::BaseInterface

      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
