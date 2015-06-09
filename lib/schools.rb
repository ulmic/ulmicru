module Schools
  def self.list
    YAML.load_file("#{Rails.root}/lib/yaml/schools.yml")['schools']
  end
end
