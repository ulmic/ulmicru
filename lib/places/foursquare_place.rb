module Places
  # FIXME make gem activerecord tableless with support of simple_form
  class FoursquarePlace
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :name, :address, :city, :state, :ll

    def initialize(attributes = {})
      attributes.each do |name, value|
        send "#{name}=", value
      end
    end

    def persisted?
      false
    end

    def save
      client = FoursquareClient.new auth: :as_organization
      @response = client.add_venue attributes
    end

    def attributes
      { name: @name, city: @city, ll: @ll, address: @address, state: @state }
    end

    def response
      @response
    end
  end
end
