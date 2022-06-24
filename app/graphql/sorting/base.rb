
module Sorting
  class Base
    class Input < Types::BaseInputObject
      argument :key, String, required: true
      argument :direction, String, required: true
    end

    def self.sort_with(scope, sort)
      return scope if sort.empty?

      sort.map(&:to_h).each do |input|
        next unless scope.has_attribute?(input[:key]) && %w[ASC DESC].include?(input[:direction].upcase)

        scope = scope.order(input[:key] => input[:direction].upcase)
      end
      scope
    end
  end
end
