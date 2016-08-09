# coding: utf-8
module PositionList
  class << self
    include RussianCases
    # FIXME слишком большая функция
    def list
      positions_structure = load_positions_yml[:positions]
      exceptions = load_positions_yml[:exceptions]
      non_existent = load_positions_yml[:non_existent]
      unless @positions_list.present?
        positions_list = []
        positions_structure.keys.each do |branch|
          positions = positions_structure[branch]
          collection = branch.camelize.constantize.active
          # FIXME any idea?
          collection = collection.ulmic if branch.camelize.constantize == ActivityLine
          collection = collection.visible if branch.camelize.constantize == Team
          if positions.is_a? Array
            positions.each do |p|
              if p.is_a? String
                collection.each do |instance|
                  full_name = "#{p.mb_chars.capitalize.to_s} #{instance.decorate.full_title(:genitive)}"
                  unless non_existent.include? full_name
                    full_name = exceptions[full_name] if exceptions[full_name]
                    positions_list << full_name
                  end
                end
              elsif p.is_a? Hash
                deputy_position_names = p[:deputy]
                deputy_position_names.each do |name|
                  collection.each do |instance|
                    full_name = "Заместитель #{genitive(name)} #{instance.decorate.full_title(:genitive)}"
                    unless non_existent.include? full_name
                      full_name = exceptions[full_name] if exceptions[full_name]
                      positions_list << full_name
                    end
                  end
                end
              end
            end
          elsif positions.is_a? Hash
            types = positions.keys
            types.each do |type|
              type_collection = type.camelize.constantize.active
              type_collection = type_collection.has_curators if type.camelize.constantize == ActivityLine
              position_names = positions[type]
              position_names.each do |position_name|
                collection.each do |instance|
                  type_collection.each do |type_instance|
                    full_name = "#{position_name.mb_chars.capitalize} #{type_instance.decorate.full_title(:genitive)} в #{instance.decorate.full_title(:dative)}"
                    unless non_existent.include? full_name
                      positions_list << full_name
                    end
                  end
                end
              end
            end
          end
        end
      end
      @positions_list ||= positions_list
    end

    def load_positions_yml
      @_cache_positions_yml ||= YAML.load_file("#{Rails.root}/lib/yaml/positions.yml").with_indifferent_access
    end
  end
end
