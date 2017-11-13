require 'active_support'
require 'action_view'
require 'mini_mime'
require 'hashie'
require 'simple_attribute/version'

module SimpleAttribute
  extend ActiveSupport::Autoload

  # Autoload base modules
  autoload :Config
  autoload :Matcher
  autoload :Builder
  autoload :Attributes
  autoload :Helpers

  # Set attr accessors
  mattr_accessor :config

  # Set config options
  @@config = Config.new

  # Setup module
  def self.setup
    yield config
  end
end

# Include action view helpers
if defined? ActionView::Base
  ActionView::Base.send :include, SimpleAttribute::Helpers
end
