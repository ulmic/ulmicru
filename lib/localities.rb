module Localities
  def self.list
    localities = self.load_yml['localities']
    list = []
    localities.each do |municipality|
      list += municipality[1]
    end
    list
  end

  def self.list_hash
    hash = self.load_yml['localities']
    hash.to_a
  end

  private

  def self.load_yml
    @_cache_localities_yml ||= YAML.load_file("#{Rails.root}/lib/yaml/localities.yml")
  end
end
