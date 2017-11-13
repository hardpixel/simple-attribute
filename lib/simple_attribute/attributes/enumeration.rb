module SimpleAttribute
  module Attributes
    class Enumeration < Base
      # Attribute name
      def attribute_name
        'enumeration'
      end

      # Link label method
      def label_method
        @options.fetch(:label, :titleize)
      end

      # Render attribute
      def render
        values = @value.to_a.map(&:"#{label_method}")
        items  = values.map { |item| @value = item; super }

        items.join.html_safe
      end
    end
  end
end
