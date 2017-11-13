module SimpleAttribute
  module Attributes
    class Video < Base
      # Attribute name
      def attribute_name
        'video'
      end

      # Render attribute
      def render_attribute
        video_tag value, html_options
      end
    end
  end
end
