module Localities
  def self.list
    localities = YAML.load_file("#{Rails.root}/lib/yaml/localities.yml")['localities']
    list = []
    localities.each do |municipality|
      list += municipality[1]
    end
    list
  end

  def self.list_hash
    hash = YAML.load_file("#{Rails.root}/lib/yaml/localities.yml")['localities']
    hash.to_a
  end
end
