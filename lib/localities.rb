module Localities
  def self.list
    localities = YAML.load_file("#{Rails.root}/lib/yaml/localities.yml")
    list = []
    localities.each do |municipality|
      list += municipality[1]
    end
    list
  end

  def self.hash
    YAML.load_file("#{Rails.root}/lib/yaml/localities.yml")
  end
end
