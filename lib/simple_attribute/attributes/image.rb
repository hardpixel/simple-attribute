module SimpleAttribute
  module Attributes
    class Image < Base
      def attribute_name
        'image'
      end

      def render_default_value
        @media_type ||= begin
          media_type = MiniMime.lookup_by_filename("#{default_value}")
          media_type.content_type.to_s.split('/').first
        end

        if 'image'.in?("#{@media_type}")
          default_url = asset_url(default_value)
          content_tag :img, nil, html_options.reverse_merge(src: default_url)
        else
          super
        end
      end

      def render_attribute
        content_tag :img, nil, html_options.reverse_merge(src: value)
      end
    end
  end
end
