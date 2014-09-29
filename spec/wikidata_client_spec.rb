require 'spec_helper'
require "webmock/rspec"
require "support/request_helpers"

describe MediawikiApi::Wikidata::WikidataClient do
  include MediawikiApi::Wikidata::RequestHelpers

  let(:client) { MediawikiApi::Wikidata::WikidataClient.new(api_url) }

  subject { client }

  describe "#create_entity" do
    subject { client.create_entity(data, type) }

    let(:data) { '{"labels":{"en":{"language":"en","value":"test_label"}},"descriptions":{"en":{"language":"en","value":"test_description"}}}' }
    let(:type) { "item" }
    let(:summary) { "Created entity using mediawiki_api/wikidata gem" }
    let(:response) { {} }

    before do
      stub_token_request(:edit)
      @edit_request = stub_action_request(:wbeditentity, data: data, new: type, summary: summary).
          to_return(body: response.to_json)
    end

    it "makes the right request" do
      subject
      expect(@edit_request).to have_been_requested
    end
  end

end
