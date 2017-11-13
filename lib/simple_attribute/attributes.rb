module SimpleAttribute
  module Attributes
    extend ActiveSupport::Concern

    # Autoload attribute decorators
    autoload :Base,        'simple_attribute/attributes/base'
    autoload :Avatar,      'simple_attribute/attributes/avatar'
    autoload :Image,       'simple_attribute/attributes/image'
    autoload :Video,       'simple_attribute/attributes/video'
    autoload :Link,        'simple_attribute/attributes/link'
    autoload :Date,        'simple_attribute/attributes/date'
    autoload :Datetime,    'simple_attribute/attributes/datetime'
    autoload :Boolean,     'simple_attribute/attributes/boolean'
    autoload :Association, 'simple_attribute/attributes/association'
    autoload :Enumeration, 'simple_attribute/attributes/enumeration'
    autoload :File,        'simple_attribute/attributes/file'
  end
end
