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
      stub_token_request(:csrf)
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
      stub_token_request(:csrf)
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
      stub_token_request(:csrf)
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
      stub_token_request(:csrf)
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
    let(:badges) { true }
    let(:response) { {} }

    before do
      stub_token_request(:csrf)
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
    let(:badges) { true }
    let(:response) { {} }

    before do
      stub_token_request(:csrf)
      @edit_request = stub_action_request(:wbsetsitelink, id: "Q1234", linksite: sitelink_site_id,
                                          linktitle: sitelink_title, badges: badges).
          to_return(body: response.to_json)
    end

    it "makes the right request" do
      subject
      expect(@edit_request).to have_been_requested
    end
  end

  describe "#create_claim" do
    subject { client.create_claim(entity_id, snaktype, property_id, value) }

    let(:entity_id) { "Q1234" }
    let(:snaktype) { "value" }
    let(:property_id) { "P1234" }
    let(:value) { '"stringtest"' }
    let(:response) { {} }

    before do
      stub_token_request(:csrf)
      @edit_request = stub_action_request(:wbcreateclaim, entity: entity_id, snaktype: snaktype, property: property_id, value: value).
          to_return(body: response.to_json)
    end

    it "makes the right request" do
      subject
      expect(@edit_request).to have_been_requested
    end
  end
  describe "#search_entities" do
    subject { client.search_entities(search, language, entity_type, limit, continue) }

    let(:search) { "test" }
    let(:language) { "en" }
    let(:entity_type) { "item" }
    let(:limit) { 10 }
    let(:continue) { "" }
    let(:response) { {} }

    before do
      @edit_request = stub_action_request_without_token(:wbsearchentities, search: search, language: language, type: entity_type,
                                                        limit: limit, continue: continue).
          to_return(body: response.to_json)
    end

    it "makes the right request" do
      subject
      expect(@edit_request).to have_been_requested
    end
  end
end
