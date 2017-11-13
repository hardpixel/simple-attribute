module SimpleAttribute
  module Attributes
    class Link < Base
      # Attribute name
      def attribute_name
        'link'
      end

      # Link label method
      def label_method
        @options.fetch(:label, :titleize)
      end

      # Link title method
      def title_method
        @options.fetch(:title, :titleize)
      end

      # Render attribute
      def render_attribute
        label = value.try(label_method)
        title = value.try(title_method)

        link_to label, value.to_s, html_options.merge(title: title)
      end
    end
  end
end
