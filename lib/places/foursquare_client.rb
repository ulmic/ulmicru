module Places
  include Foursquare2

  OAUTH_KEYS = YAML.load_file(Rails.root.join('config', 'oauth.yml'))[Rails.env].with_indifferent_access

  class FoursquareClient
    def initialize(options = {})
      foursquare_client_options = { client_id: OAUTH_KEYS[:foursquare][:client_id],
                                    client_secret: OAUTH_KEYS[:foursquare][:client_secret],
                                    api_version: configus.api.foursquare.version }
      foursquare_client_options[:oauth_token] = OAUTH_KEYS[:foursquare][:organization_account_access_token] if options[:auth] == :as_organization
      @client = Foursquare2::Client.new foursquare_client_options
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

    def venue_by_id(id)
      @client.venue id if id.present?
    end

    def add_venue(params)
      @client.add_venue params
    end

    private

    def important_localities
      YAML.load_file("#{Rails.root}/lib/yaml/important_localities_coordinates.yml")['important_localities']
    end
  end
end
