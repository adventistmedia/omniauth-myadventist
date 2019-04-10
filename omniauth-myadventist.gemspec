# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-myadventist/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-myadventist"
  spec.version       = OmniAuth::Myadventist::VERSION
  spec.authors       = ["Adventist Media"]
  spec.email         = ["webmaster@adventistmedia.org.au"]

  spec.summary       = %q{myAdventist omniauth strategy}
  spec.description   = %q{myAdventist omniauth strategy}
  spec.homepage      = "http://myadventist.org"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0'

  spec.add_dependency 'omniauth-oauth2', '~> 1.6.0'
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 12.0"
end
