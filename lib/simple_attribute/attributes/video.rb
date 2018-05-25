module SimpleAttribute
  module Attributes
    class Video < Base
      # Attribute name
      def attribute_name
        'video'
      end

      # Render attribute
      def render_attribute
        content_tag :video, nil, html_options.reverse_merge(src: value)
      end
    end
  end
end
