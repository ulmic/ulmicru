module PositionList
  class << self
    def list
      positions_structure = YAML.load_file("#{Rails.root}/lib/yaml/positions.yml").with_indifferent_access[:positions]
      positions_list = []
      positions_structure.keys.each do |branch|
        positions = positions_structure[branch]
        positions.each do |p|
          branch.camelize.constantize.active.each do |instance|
            positions_list << "#{p} #{instance.decorate.full_title(:genitive)}"
          end
        end
      end
      positions_list
    end
  end
end
