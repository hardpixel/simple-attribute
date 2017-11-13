module SimpleAttribute
  module Attributes
    class Date < Base
      # Date default format
      def default_format
        '<date>%d %b %Y</date>'
      end

      # Date format
      def date_format
        options.fetch :format, default_format
      end

      # Render attribute
      def render_attribute
        value.try :strftime, date_format
      end
    end
  end
end
