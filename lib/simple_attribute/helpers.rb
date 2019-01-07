module SimpleAttribute
  module Helpers
    def simple_attribute_for(record, attribute, options = {})
      options = options.merge(record: record, attribute: attribute)
      SimpleAttribute::Builder.new(self, options).render
    end

    alias :attribute_for :simple_attribute_for
  end
end
