require 'active_support'
require 'action_view'
require 'mini_mime'
require 'hashie'
require 'simple_attribute/version'

module SimpleAttribute
  extend ActiveSupport::Autoload

  autoload :Config
  autoload :Matcher
  autoload :Builder
  autoload :Attributes
  autoload :Helpers

  mattr_accessor :config

  @@config = Config.new

  def self.setup
    yield config
  end
end

if defined? ActionView::Base
  ActionView::Base.send :include, SimpleAttribute::Helpers
end
