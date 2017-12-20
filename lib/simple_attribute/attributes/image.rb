module SimpleAttribute
  module Attributes
    class Image < Base
      # Attribute name
      def attribute_name
        'image'
      end

      # Get default value
      def default_value
        default = @options.fetch :default_value, nil
        default = asset_path(default) rescue nil

        default.nil? ? super : default
      end

      # Render default value
      def render_default_value
        if default_value.present?
          image_tag default_value, html_options
        end
      end

      # Render attribute
      def render_attribute
        image_tag value, html_options
      end
    end
  end
end
