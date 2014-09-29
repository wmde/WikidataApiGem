# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mediawiki_api/wikidata/version'

Gem::Specification.new do |spec|
  spec.name          = "mediawiki_api-wikidata"
  spec.version       = MediawikiApi::Wikidata::VERSION
  spec.authors       = ["Tobias Gritschacher"]
  spec.email         = ["tobias.gritschacher@wikimedia.de"]
  spec.description   = %q{A library for interacting with the Wikidata API from Ruby.}
  spec.summary       = %q{Extends the MediaWiki API Gem.}
  spec.homepage      = "https://github.com/wmde/WikidataApiGem"
  spec.license       = "GPL-2"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "mediawiki_api", "~> 0.2.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 0"
  spec.add_development_dependency "rspec", "~> 3.0", ">= 3.0.0"
  spec.add_development_dependency "webmock", "~> 1.17", ">= 1.17.2"
  spec.add_development_dependency "redcarpet"
  spec.add_development_dependency "yard"
end
