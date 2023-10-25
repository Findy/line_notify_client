# frozen_string_literal: true

$:.push File.expand_path('../lib', __FILE__)

require 'line_notify_client/version'

Gem::Specification.new do |s|
  s.name        = 'line_notify_client'
  s.version     = LineNotify::VERSION
  s.authors     = ['Shojiro Yanagisawa']
  s.email       = ['nipe0324@gmail.com']
  s.homepage    = 'https://github.com/Findy/line_notify_client'
  s.summary     = 'LINE Notify API client library'
  s.description = 'LINE Notify API client library'
  s.licenses    = ['MIT']

  s.files       = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.require_paths = ["lib"]

  s.add_dependency 'faraday', '>= 2', '< 3'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'webmock'
end
