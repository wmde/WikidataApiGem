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
wikidata_client.create_entity "data" #create a new item specified by "data"
```

## Release notes

### 0.0.1 (2014-09-29)

- Initial version
- supports creation of entities via wbeditentity
