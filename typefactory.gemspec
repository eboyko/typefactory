# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'typefactory/version'

Gem::Specification.new do |spec|
  spec.name          = 'typefactory'
  spec.version       = Typefactory::VERSION
  spec.authors       = ['Evgeny Boyko', 'Boandmedia']
  spec.email         = ['eboyko@eboyko.ru']
  spec.summary       = 'Helps you to prepare your texts for publishing on the web'
  spec.description   = 'Helps you to prepare your texts for publishing on the web'
  spec.homepage      = 'http://boandmedia.com'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.1', '>= 10.1.0'
  spec.add_development_dependency 'rspec', '~> 3.0', '>= 3.0.0'
end
