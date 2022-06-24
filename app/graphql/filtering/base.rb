
module Filtering
  class Base
    class Input < Types::BaseInputObject
      argument :key, String, required: true
      argument :filter, String, required: true
    end

    def self.filter_with(scope, filter)
      return scope if filter.empty?

      filter.map(&:to_h).each do |input|
        next unless scope.has_attribute?(input[:key]) && !input[:filter].empty?

        scope = scope.where("#{input[:key]} Like ?", "%#{input[:filter]}%")
      end
      scope
    end
  end
end
