module Schools
  def self.list
    schools = YAML.load_file("#{Rails.root}/lib/yaml/schools.yml")['schools']
    list = []
    schools.each do |municipality|
      list += municipality[1]
    end
    list
  end

  def self.list_hash
    hash = YAML.load_file("#{Rails.root}/lib/yaml/schools.yml")['schools']
    hash.to_a
  end
end
