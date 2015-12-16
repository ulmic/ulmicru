module Schools
  def self.list
    schools = self.load_yml['schools']
    list = []
    schools.each do |municipality|
      list += municipality[1]
    end
    list
  end

  def self.list_hash
    hash = self.load_yml['schools']
    hash.to_a
  end

  private

  def self.load_yml
    @_cache_shools_yml ||= YAML.load_file("#{Rails.root}/lib/yaml/schools.yml")
  end
end
