module SocialNetworks
  def self.list
    YAML.load_file("#{Rails.root}/lib/yaml/social_networks.yml").with_indifferent_access[:social_networks]
  end
end
