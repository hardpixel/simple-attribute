module SimpleAttribute
  module Attributes
    class Avatar < Base
      # Attribute name
      def attribute_name
        'avatar'
      end

      # Image size
      def size
        options.fetch :size, 19
      end

      # Get gravatar
      def gravatar
        hash = Digest::MD5::hexdigest(value)
        "https://www.gravatar.com/avatar/#{hash}?rating=PG&size=#{size}&default=mm"
      end

      # Get custom avatar
      def custom_avatar
        attribute = options.fetch :avatar, nil
        record.try attribute if attribute
      end

      # Render attribute
      def render_attribute
        avatar  = custom_avatar || gravatar
        classes = "#{html_options[:class]} avatar-image".strip
        options = html_options.merge({ class: classes, width: size, height: size })

        image_tag avatar, options
      end
    end
  end
end
