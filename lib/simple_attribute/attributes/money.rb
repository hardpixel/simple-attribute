module SimpleAttribute
  module Attributes
    class Money < Base
      def render_attribute
        value.try :format
      end
    end
  end
end
