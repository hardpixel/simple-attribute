module SimpleAttribute
  module Attributes
    class Image < Base
      def attribute_name
        'image'
      end

      def media_type
        @media_type ||= begin
          type = MiniMime.lookup_by_filename(default_value.to_s)
          type.content_type.to_s.split('/').first
        end
      end

      def render_default_value
        return super unless 'image'.in?(media_type.to_s)

        default_url = asset_url(default_value)
        content_tag :img, nil, html_options.reverse_merge(src: default_url)
      end

      def render_attribute
        content_tag :img, nil, html_options.reverse_merge(src: value)
      end
    end
  end
end
