module Sorting
  class Base
    class Input < Types::BaseInputObject
      argument :key, String, required: true
      argument :direction, String, required: true
    end

    def self.sort_with(scope, sort)
      return scope if sort.empty?
      return scope unless scope.has_attribute?(sort[:key]) && %w[ASC DESC].include?(sort[:direction].upcase)

      scope.order(sort[:key] => sort[:direction].upcase)

    end
  end
end
