module PositionList
  class << self
    def list
      positions_structure = YAML.load_file("#{Rails.root}/lib/yaml/positions.yml").with_indifferent_access[:positions]
      exceptions = YAML.load_file("#{Rails.root}/lib/yaml/positions.yml").with_indifferent_access[:exceptions]
      positions_list = []
      positions_structure.keys.each do |branch|
        positions = positions_structure[branch]
        positions.each do |p|
          branch.camelize.constantize.active.each do |instance|
            if p.is_a? String
              full_name = "#{p.mb_chars.capitalize.to_s} #{instance.decorate.full_title(:genitive)}"
              full_name = exceptions[full_name] if exceptions[full_name]
              positions_list << full_name
            end
          end
        end
      end
      positions_list
    end
  end
end
