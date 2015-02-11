# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'state_machines/integrations/mongoid/version'

Gem::Specification.new do |spec|
  spec.name          = 'state_machines-mongoid'
  spec.version       = StateMachines::Integrations::Mongoid::VERSION
  spec.authors       = ['Abdelkader Boudih']
  spec.email         = ['terminale@gmail.com']
  spec.summary       = 'Mongoid integration for state machines'
  spec.description   = 'Mongoid integration for state machines gem'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version     = '>= 1.9.3'
  spec.add_dependency 'state_machines-activemodel'    , '>= 0'
  spec.add_dependency 'mongoid' , '>= 4.0.0'
  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_development_dependency 'minitest', '>= 5.4.1'
  spec.add_development_dependency 'minitest-reporters'
end
