module SimpleAttribute
  module Attributes
    class Datetime < Date
      def default_format
        '<date>%d %b %Y</date> <time>%H:%M</time>'
      end
    end
  end
end
