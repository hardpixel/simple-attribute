module SimpleAttribute
  module Attributes
    class Money < Base
      # Render attribute
      def render_attribute
        value.try :format
      end
    end
  end
end
