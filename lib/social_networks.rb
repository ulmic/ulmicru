module SocialNetworks
  def self.localize(network_name)
    networks = YAML.load_file("#{Rails.root}/lib/yaml/social_networks.yml").with_indifferent_access[:social_networks]
    networks[network_name]
  end

  def self.list
    YAML.load_file("#{Rails.root}/lib/yaml/social_networks.yml").with_indifferent_access[:social_networks].keys
  end
end
