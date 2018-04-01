# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/teachbase-oauth2/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-teachbase-oauth2'
  spec.version       = OmniAuth::TeachbaseOAuth2::VERSION
  spec.authors       = ['Andrey Paderin']
  spec.email         = ['paderinandrey2011@gmail.com']

  spec.summary       = 'OmniAuth strategy for Teachbase OAuth API'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.3'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'omniauth', '~> 1.5'
  spec.add_dependency 'omniauth-oauth2', '~> 1.4'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.42'
  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'webmock', '~> 2.1'
end
