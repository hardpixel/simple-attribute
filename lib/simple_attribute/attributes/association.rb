module SimpleAttribute
  module Attributes
    class Association < Base
      def attribute_name
        'association'
      end

      def label_method
        @options.fetch(:label, :id)
      end

      def title_method
        @options.fetch(:title, :id)
      end

      def url_method
        @options.fetch(:url, nil)
      end

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
