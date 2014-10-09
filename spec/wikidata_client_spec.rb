require 'spec_helper'
require "webmock/rspec"
require "support/request_helpers"

describe MediawikiApi::Wikidata::WikidataClient do
  include MediawikiApi::Wikidata::RequestHelpers

  let(:client) { MediawikiApi::Wikidata::WikidataClient.new(api_url) }

  subject { client }

  describe "#create_entity" do
    subject { client.create_entity(data, type) }

    let(:data) { '{"labels":{"en":{"language":"en","value":"test_label"}},
                   "descriptions":{"en":{"language":"en","value":"test_description"}}}' }
    let(:type) { "item" }
    let(:response) { {} }

    before do
      stub_token_request(:edit)
      @edit_request = stub_action_request(:wbeditentity, data: data, new: type).
          to_return(body: response.to_json)
    end

    it "makes the right request" do
      subject
      expect(@edit_request).to have_been_requested
    end
  end

  describe "#create_item" do
    subject { client.create_item(data) }

    let(:data) { '{"labels":{"en":{"language":"en","value":"test_label"}},
                   "descriptions":{"en":{"language":"en","value":"test_description"}}}' }
    let(:response) { {} }

    before do
      stub_token_request(:edit)
      @edit_request = stub_action_request(:wbeditentity, data: data, new: "item").
          to_return(body: response.to_json)
    end

    it "makes the right request" do
      subject
      expect(@edit_request).to have_been_requested
    end
  end

  describe "#create_property" do
    subject { client.create_property(data) }

    let(:data) { '{"labels":{"en":{"language":"en","value":"test_label"}},
                   "descriptions":{"en":{"language":"en","value":"test_description"}},"datatype":"string"}' }
    let(:response) { {} }

    before do
      stub_token_request(:edit)
      @edit_request = stub_action_request(:wbeditentity, data: data, new: "property").
          to_return(body: response.to_json)
    end

    it "makes the right request" do
      subject
      expect(@edit_request).to have_been_requested
    end
  end

  describe "#create_property" do
    subject { client.create_property(data) }

    let(:data) { '{"labels":{"en":{"language":"en","value":"test_label"}},
                   "descriptions":{"en":{"language":"en","value":"test_description"}},"datatype":"string"}' }
    let(:response) { {} }

    before do
      stub_token_request(:edit)
      @edit_request = stub_action_request(:wbeditentity, data: data, new: "property").
          to_return(body: response.to_json)
    end

    it "makes the right request" do
      subject
      expect(@edit_request).to have_been_requested
    end
  end

  describe "#set_sitelink (item identified by site/title)" do
    subject { client.set_sitelink(entity_identifier, sitelink_site_id, sitelink_title, badges) }

    let(:entity_identifier) { {site_id: "dewiki", title: "Berlin"} }
    let(:sitelink_site_id) { "itwiki" }
    let(:sitelink_title) { "Berlino" }
    let(:badges) { nil }
    let(:response) { {} }

    before do
      stub_token_request(:edit)
      @edit_request = stub_action_request(:wbsetsitelink, site: "dewiki", title: "Berlin", linksite: sitelink_site_id,
                                          linktitle: sitelink_title, badges: badges).
          to_return(body: response.to_json)
    end

    it "makes the right request" do
      subject
      expect(@edit_request).to have_been_requested
    end
  end

  describe "#set_sitelink (item identified by ID)" do
    subject { client.set_sitelink(entity_identifier, sitelink_site_id, sitelink_title, badges) }

    let(:entity_identifier) { "Q1234" }
    let(:sitelink_site_id) { "itwiki" }
    let(:sitelink_title) { "Berlino" }
    let(:badges) { nil }
    let(:response) { {} }

    before do
      stub_token_request(:edit)
      @edit_request = stub_action_request(:wbsetsitelink, id: "Q1234", linksite: sitelink_site_id,
                                          linktitle: sitelink_title, badges: badges).
          to_return(body: response.to_json)
    end

    it "makes the right request" do
      subject
      expect(@edit_request).to have_been_requested
    end
  end

end
