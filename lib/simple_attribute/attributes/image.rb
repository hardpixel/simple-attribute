module SimpleAttribute
  module Attributes
    class Image < Base
      # Attribute name
      def attribute_name
        'image'
      end

      # Render attribute
      def render_attribute
        image_tag value, html_options
      end
    end
  end
end
