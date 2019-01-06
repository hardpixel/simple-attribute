lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_attribute/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_attribute'
  spec.version       = SimpleAttribute::VERSION
  spec.authors       = ['Jonian Guveli']
  spec.email         = ['jonian@hardpixel.eu']
  spec.summary       = %q{Decorate ActiveRecord model attributes}
  spec.description   = %q{Attribute decorator support for ActiveRecord models.}
  spec.homepage      = 'https://github.com/hardpixel/simple-attribute'
  spec.license       = 'MIT'
  spec.files         = Dir['{lib/**/*,[A-Z]*}']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'actionview', '~> 5.0'
  spec.add_dependency 'hashie', '~> 3.5'
  spec.add_dependency 'mini_mime', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
