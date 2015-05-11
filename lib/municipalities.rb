module Municipalities
  def self.list
    YAML.load_file("#{Rails.root}/lib/yaml/municipalities.yml")["municipalities"]
  end
end
