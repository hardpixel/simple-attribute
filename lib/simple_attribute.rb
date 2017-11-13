require 'active_support'
require 'action_view'
require 'hashie'
require 'simple_attribute/version'

module SimpleAttribute
  extend ActiveSupport::Concern

  # Autoload base modules
  autoload :Config,     'simple_attribute/config'
  autoload :Builder,    'simple_attribute/builder'
  autoload :Helpers,    'simple_attribute/helpers'
  autoload :Attributes, 'simple_attribute/attributes'

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
