# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mediawiki_api/wikidata/version'

Gem::Specification.new do |spec|
  spec.name          = "mediawiki_api-wikidata"
  spec.version       = MediawikiApi::Wikidata::VERSION
  spec.authors       = ["Tobias Gritschacher"]
  spec.email         = ["tobias.gritschacher@wikimedia.de"]
  spec.description   = "Wikidata API extending the mediawiki API gem"
  spec.summary       = "Wikidata API extending the mediawiki API gem"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "mediawiki_api"
end
