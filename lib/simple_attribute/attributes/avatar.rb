module SimpleAttribute
  module Attributes
    class Avatar < Base
      def attribute_name
        'avatar'
      end

      def size
        options.fetch :size, 19
      end

      def gravatar
        hash = Digest::MD5::hexdigest(value)
        "https://www.gravatar.com/avatar/#{hash}?rating=PG&size=#{size}&default=mm"
      end

      def custom_avatar
        attribute = options.fetch :avatar, nil
        record.try attribute if attribute
      end

      def render_attribute
        avatar  = custom_avatar || gravatar
        classes = "#{html_options[:class]} avatar-image".strip
        options = html_options.merge({ class: classes, width: size, height: size })

        image_tag avatar, options
      end
    end
  end
end
