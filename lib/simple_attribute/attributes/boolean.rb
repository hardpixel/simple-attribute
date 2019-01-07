module SimpleAttribute
  module Attributes
    class Boolean < Base
      def invert_classes?
        options[:invert] == true
      end

      def true_class
        invert_classes? ? options[:false] : options[:true]
      end

      def false_class
        invert_classes? ? options[:true] : options[:false]
      end

      def wrapper_html
        classes = value? ? true_class : false_class
        classes = "#{super[:class]} #{classes}".strip

        super.merge(class: classes)
      end

      def render_default_value
        'No'
      end

      def render_attribute
        'Yes'
      end
    end
  end
end
