module SimpleAttribute
  module Attributes
    class Link < Base
      def attribute_name
        'link'
      end

      def label_method
        @options.fetch(:label, :titleize)
      end

      def title_method
        @options.fetch(:title, :titleize)
      end

      def render_attribute
        label = value.try(label_method)
        title = value.try(title_method)

        link_to label, value.to_s, html_options.merge(title: title)
      end
    end
  end
end
