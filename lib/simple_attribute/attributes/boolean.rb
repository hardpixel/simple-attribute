module SimpleAttribute
  module Attributes
    class Boolean < Base
      # Invert classes
      def invert_classes?
        options[:invert] == true
      end

      # True class
      def true_class
        invert_classes? ? options[:false] : options[:true]
      end

      # False class
      def false_class
        invert_classes? ? options[:true] : options[:false]
      end

      # Wrapper html
      def wrapper_html
        classes = value? ? true_class : false_class
        classes = "#{super[:class]} #{classes}".strip

        super.merge(class: classes)
      end

      # Render default attribute
      def render_default_value
        'No'
      end

      # Render attribute
      def render_attribute
        'Yes'
      end
    end
  end
end
