module SimpleAttribute
  module Attributes
    extend ActiveSupport::Autoload

    # Autoload attribute decorators
    autoload :Base
    autoload :Avatar
    autoload :Image
    autoload :Video
    autoload :Link
    autoload :Date
    autoload :Datetime
    autoload :Boolean
    autoload :Association
    autoload :Enumeration
    autoload :File
  end
end
