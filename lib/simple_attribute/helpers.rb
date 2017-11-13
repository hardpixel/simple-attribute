module SimpleAttribute
  module Helpers
    # Render simple attribute
    def simple_attribute_for(record, attribute, options={})
      options = options.merge(record: record, attribute: attribute)
      SimpleAttribute::Builder.new(self, options).render
    end

    # Alias helper method
    alias :attribute_for :simple_attribute_for
  end
end
