module Accesses
  def self.attributes
    YAML.load_file("#{Rails.root}/lib/yaml/accesses.yml").with_indifferent_access[:attributes]
  end
end
