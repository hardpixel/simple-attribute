module SimpleAttribute
  module Attributes
    class Image < Base
      # Attribute name
      def attribute_name
        'image'
      end

      # Render default value
      def render_default_value
        @media_type ||= begin
          media_type = MiniMime.lookup_by_filename("#{default_value}")
          media_type.content_type.to_s.split('/').first
        end

        if 'image'.in?("#{@media_type}")
          default_url = asset_url(default_value)
          image_tag default_url, html_options
        else
          super
        end
      end

      # Render attribute
      def render_attribute
        image_tag value, html_options
      end
    end
  end
end
