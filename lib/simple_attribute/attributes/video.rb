module SimpleAttribute
  module Attributes
    class Video < Base
      def attribute_name
        'video'
      end

      def render_attribute
        content_tag :video, nil, html_options.reverse_merge(src: value)
      end
    end
  end
end
