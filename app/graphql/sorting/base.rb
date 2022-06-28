
module Sorting
  class Base
    class SortInput < Types::BaseInputObject
      argument :key, String, required: true
      argument :direction, Types::SortDirection, required: true
    end

    def self.sort_with(scope, sort)
      return scope if sort.empty?

      sort.map(&:to_h).each do |input|
        next unless scope.has_attribute?(input[:key])

        scope = scope.order(input[:key] => input[:direction].upcase)
      end
      scope
    end
  end
end
