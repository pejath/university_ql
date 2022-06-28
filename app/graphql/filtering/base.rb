
module Filtering
  class Base
    class FilterInput < Types::BaseInputObject
      argument :key, String, required: true
      argument :filter, String, required: true
    end

    def self.filter_with(scope, filter)
      return scope if filter.empty?
      result = []
      filter.map(&:to_h).each do |input|
        next unless scope.has_attribute?(input[:key]) && !input[:filter].empty?

        result += if scope.columns_hash[input[:key]].type == :integer
                    scope.where(input[:key] => input[:filter])
                  else
                    scope.where("#{input[:key]} Like ?", "%#{input[:filter]}%")
                  end
      end
      scope.where(id: result.pluck(:id))
    end
  end
end
