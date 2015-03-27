module FoursquareHelper
  include Foursquare2
  OAUTH_KEYS = YAML.load_file(Rails.root.join('config', 'oauth.yml'))[Rails.env].with_indifferent_access

  class FoursquareClient
    def initialize
      @client = Foursquare2::Client.new client_id: OAUTH_KEYS[:foursquare_client_id], client_secret: OAUTH_KEYS[:foursquare_client_secret], api_version: '20140806'
    end

    def search_venues_by_name(query)
      venues = @client.search_venues ll: '54.32824, 48.38657', query: query
    end
  end
end
