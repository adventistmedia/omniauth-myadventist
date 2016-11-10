# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-myadventist/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-myadventist"
  spec.version       = OmniAuth::Myadventist::VERSION
  spec.authors       = ["Dan Lewis"]
  spec.email         = ["webmaster@adventistmedia.org.au"]

  spec.summary       = %q{myAdventist Omniauth strategy}
  spec.description   = %q{myAdventist Omniauth strategy}
  spec.homepage      = "myadventist.org.au."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth-oauth', '~> 1.1'
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
