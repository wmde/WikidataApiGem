# WikidataAPI

[![Build Status](https://api.travis-ci.org/wmde/WikidataApiGem.png?branch=master)](http://travis-ci.org/wmde/WikidataApiGem)

A library for interacting with the Wikidata API from Ruby.
Extends the [MediaWiki API Gem](https://github.com/wikimedia/mediawiki-ruby-api).

## Installation

Add this line to your application's Gemfile:

    gem 'mediawiki_api-wikidata'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mediawiki_api-wikidata

## Usage

```ruby
require "mediawiki_api/wikidata"

wikidata_client = MediawikiApi::Wikidata::WikidataClient.new "http://127.0.0.1/w/api.php" #instantiate new client
wikidata_client.log_in "username", "password" #log in via the API
wikidata_client.create_item "data" #create a new item specified by "data"
wikidata_client.create_property "data" #create a new property specified by "data"
wikidata_client.add_sitelink "Q1234", "enwiki", "Berlin" #add a new sitelink enwiki/Berlin to item Q1234
wikidata_client.remove_sitelink "Q1234", "enwiki" #remove enwiki sitelink from item Q1234
wikidata_client.sitelink_exists? "enwiki", "Berlin" #returns true if enwiki/Berlin sitelink exists, false otherwise
wikidata_client.create_claim "Q1234", "value", "P1234", '"test"' #adds claim with property P1234 and value "test" to item Q1234
wikidata_client.search_entities "test", "en", "item" #searches for items containing the string "test" in their english labels, descriptions and aliases
```

## Release notes

### 0.1 (dev)
- support creating claims
- support searching entities

### 0.0.2 (2014-10-09)

- support adding sitelinks
- support changing sitelinks
- support removing sitelinks
- support checking for existing sitelinks
- provide separate methods for creating items and properties
- removed custom edit summaries

### 0.0.1 (2014-09-29)

- Initial version
- supports creation of entities via wbeditentity
