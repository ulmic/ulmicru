module Municipalities
  def self.list
    self.load_yml["municipalities"]
  end

  private

  def self.load_yml
    @_cache_municipalities_yml ||= YAML.load_file("#{Rails.root}/lib/yaml/municipalities.yml")
  end
end
