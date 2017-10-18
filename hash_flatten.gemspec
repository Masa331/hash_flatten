# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hash_flatten/version"

Gem::Specification.new do |spec|
  spec.name          = "hash_flatten"
  spec.version       = HashFlatten::VERSION
  spec.authors       = ["Premysl Donat"]
  spec.email         = ["pdonat@seznam.cz"]

  spec.summary       = "Just one method i miss in std lib"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/Masa331/hash_flatten"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
