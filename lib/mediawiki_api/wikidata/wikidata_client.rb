require "mediawiki_api/wikidata/version"

module MediawikiApi
  module Wikidata
    class WikidataClient < Client

      def create_entity(data, type = "item")
        action(:wbeditentity, token_type: "edit", new: type, data: data, summary:"Created entity using mediawiki_api-wikidata gem")
      end

    end
  end
end
