module MediawikiApi
  module Wikidata
    class WikidataApiError < ApiError

    end

    class EntityIdentifierMismatchError < StandardError
    end
  end
end
