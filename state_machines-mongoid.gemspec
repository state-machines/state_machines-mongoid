# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'state_machines/integrations/mongoid/version'

Gem::Specification.new do |spec|
  spec.name          = 'state_machines-mongoid'
  spec.version       = StateMachines::Integrations::Mongoid::VERSION
  spec.authors       = ['Abdelkader Boudih', 'Aaron Pfeifer']
  spec.email         = %w(terminale@gmail.com aaron@pluginaweek.org)
  spec.summary       = 'Mongoid integration for state machines'
  spec.description   = 'Mongoid integration for state machines gem'
  spec.homepage      = 'https://github.com/state-machines/state_machines-mongoid'
  spec.license       = 'MIT'

  spec.files         = Dir['{lib}/**/*', 'LICENSE.txt', 'README.md']
  spec.test_files    = Dir['test/**/*']
  spec.require_paths = ['lib']

  spec.required_ruby_version     = '>= 3.0.0'
  spec.add_dependency 'state_machines-activemodel', '>= 0.5.0'
  spec.add_dependency 'mongoid' , '>= 6.0.0'

  spec.add_development_dependency 'bundler', '>= 1.6'
  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_development_dependency 'minitest', '>= 5.4.1'
  spec.add_development_dependency 'minitest-reporters'
end
