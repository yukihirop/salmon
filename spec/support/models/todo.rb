module Salmon
  class Todo < ApplicationRecord
    class << self
      def attributes
        result = {}
        self.columns.each { |c| result[c.name] = c.type }
        result
      end

      def rspec_valid_hash
        result = {}
        self.attributes.each do |key, val|
          case val
            when 'boolean'
              result[key] = true
            when 'integer'
              result[key] = 12345
            else
              result[key] = 'hogehoge'
            end
        end
        result
      end

      def rspec_invalid_hash
        result = {}
        self.attributes.each do |key, val|
          result[key] = nil
        end
        result
      end

    end
  end
end