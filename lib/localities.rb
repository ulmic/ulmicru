module Localities
  def self.list
    localities = self.load_localities_yml['localities']
    list = []
    localities.each do |municipality|
      list += municipality[1]
    end
    list
  end

  def self.list_hash
    hash = self.load_localities_yml['localities']
    hash.to_a
  end

  private

  def self.load_localities_yml
    @_localities_yml ||= YAML.load_file("#{Rails.root}/lib/yaml/localities.yml")
  end
end
