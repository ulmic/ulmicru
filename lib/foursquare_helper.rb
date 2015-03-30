module FoursquareHelper
  include Foursquare2
  OAUTH_KEYS = YAML.load_file(Rails.root.join('config', 'oauth.yml'))[Rails.env].with_indifferent_access

  class FoursquareClient
    def initialize
      @client = Foursquare2::Client.new client_id: OAUTH_KEYS[:foursquare_client_id], client_secret: OAUTH_KEYS[:foursquare_client_secret], api_version: '20140806'
    end

    def search_venues_by_name(query)
      localities = important_localities
      localities.keys.each do |locality|
        if query.mb_chars.downcase.to_s.include? locality
          return @client.search_venues ll: localities[locality], query: query
        end
      end
      @client.search_venues ll: localities[localities.keys.first], query: query
    end

    private

    def important_localities
      YAML.load_file("#{Rails.root}/lib/yaml/important_localities_coordinates.yml")['important_localities']
    end
  end
end
