# Author:: Tobias Gritschacher (tobias.gritschacher@wikimedia.de)
# License:: GNU GPL v2+

require "mediawiki_api/wikidata/version"
require "mediawiki_api/wikidata/exceptions"

module MediawikiApi
  module Wikidata
    class WikidataClient < Client

      def create_entity(entity_data, type)
        action(:wbeditentity, token_type: "edit", new: type, data: entity_data, summary: "Created entity using mediawiki_api/wikidata gem")
      end

      def create_item(item_data)
        create_entity(item_data, "item")
      end

      def create_property(property_data)
        create_entity(property_data, "property")
      end

      def set_sitelink(entity_id = nil, site_id = nil, title = nil, sitelink_site_id, sitelink_title, badges)
        params = { token_type: "edit", linksite: sitelink_site_id, linktitle: sitelink_title, badges: badges, summary: "Set sitelink using mediawiki_api/wikidata gem" }
        action(:wbsetsitelink, params.merge(get_entity_identifier(entity_id, site_id, title)))
      end

      private

      def get_entity_identifier(entity_id, site_id, title)
        if entity_id
          { id: entity_id }
        elsif site_id && title
          { site: site_id, title: title }
        else
          raise EntityIdentifierMismatchError, "Either entity id or site id and page title need to be set to identify the entity."
        end
      end

    end
  end
end
