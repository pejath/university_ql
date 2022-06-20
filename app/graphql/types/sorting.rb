module Sorting
  class Input < Types::BaseInputObject
    argument :key, String, required: true
    argument :direction, String, required: true
  end

  class Base
    def self.sorting_with(scope, sort)
      # inputs.map(&:to_h).each do |input|
      #   input.each do |key, direction|
      return scope unless scope.has_attribute?(sort[key]) || ['ASC','DESC'].include?(sort[direction].upcase)

      scope = scope.order(key => direction)
        # end
      # end
      # scope
    end
  end
end
