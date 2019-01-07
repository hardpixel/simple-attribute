module SimpleAttribute
  module Attributes
    class Date < Base
      def default_format
        '<date>%d %b %Y</date>'
      end

      def date_format
        options.fetch :format, default_format
      end

      def render_attribute
        value.try :strftime, date_format
      end
    end
  end
end
