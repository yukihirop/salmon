module Salmon
  class Todo < ApplicationRecord
    class << self
      def attributes
        result = {}
        self.columns.each { |c| result[c.name] = c.type }
        result
      end
    end
  end
end