# Author:: Tobias Gritschacher (tobias.gritschacher@wikimedia.de)
# License:: GNU GPL v2+

require "mediawiki_api/wikidata/version"
require "mediawiki_api/wikidata/exceptions"

module MediawikiApi
  module Wikidata
    class WikidataClient < Client

      def create_entity(entity_data, type)
        action(:wbeditentity, token_type: "edit", new: type, data: entity_data)
      end

      def create_item(item_data)
        create_entity(item_data, "item")
      end

      def create_property(property_data)
        create_entity(property_data, "property")
      end

      def set_sitelink(entity_identifier, sitelink_site_id, sitelink_title = nil, badges = nil)
        params = { token_type: "edit", linksite: sitelink_site_id, linktitle: sitelink_title, badges: badges}
        action(:wbsetsitelink, params.merge(parse_entity_identifier(entity_identifier)))
      end

      def add_sitelink(entity_identifier, sitelink_site_id, sitelink_title, badges = nil)
        set_sitelink(entity_identifier, sitelink_site_id, sitelink_title, badges)
      end

      def remove_sitelink(entity_identifier, sitelink_site_id)
        set_sitelink(entity_identifier, sitelink_site_id)
      end

      def sitelink_exists?(site_id, title)
        resp = get_entities({site_ids: [site_id], titles: [title]}, ["info"])
        !resp.data["entities"]["-1"]
      end

      def search_entities(search, language, entity_type, limit = 10, continue = nil)
        action(:wbsearchentities, token_type: false, search: search, language: language, type: entity_type, limit: limit,
               continue: continue)
      end

      def create_claim(entity_id, snaktype = "value", property_id, value_data)
        action(:wbcreateclaim, token_type: "edit", entity: entity_id, snaktype: snaktype, property: property_id, value: value_data)
      end

      def get_entities(entity_identifiers, props = false, languages = false, sitefilter = false, ungroupedlist = false, redirects = false, languagefallback = false, normalize = false)
        params = { token_type: false, props: props, languages: languages, sitefilter: sitefilter,
                   ungroupedlist: ungroupedlist, redirects: redirects, languagefallback: languagefallback, normalize: normalize }
        action(:wbgetentities, params.merge(parse_entity_identifiers(entity_identifiers)))
      end

      private

      def parse_entity_identifier(identifier)
        if identifier.is_a?(::Hash)
          { site: identifier[:site_id], title: identifier[:title] }
        elsif identifier.is_a?(String)
          { id: identifier }
        else
          raise EntityIdentifierMismatchError, "Either entity id or site id and page title need to be set to identify the entity."
        end
      end

      def parse_entity_identifiers(identifiers)
        if identifiers.is_a?(::Hash)
          { sites: identifiers[:site_ids], titles: identifiers[:titles] }
        elsif identifiers.is_a?(Array)
          { ids: identifiers }
        else
          raise EntityIdentifierMismatchError, "Either an array of entity ids or site ids and page titles need to be set to identify the entity."
        end
      end

    end
  end
end
