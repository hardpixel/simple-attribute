module SimpleAttribute
  module Attributes
    class Association < Base
      # Attribute name
      def attribute_name
        'association'
      end

      # Link label method
      def label_method
        @options.fetch(:label, :id)
      end

      # Link title method
      def title_method
        @options.fetch(:title, :id)
      end

      # Link url method
      def url_method
        @options.fetch(:url, nil)
      end

      # Render attribute
      def render_attribute
        label = value.try(label_method)
        title = value.try(title_method)

        unless url_method.nil?
          value = @context.send(url_method, @value)
        end

        link_to label, value, html_options.merge(title: title)
      end
    end
  end
end
