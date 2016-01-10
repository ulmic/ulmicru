module Concerns
  module Trash
    def to_trash_param(type)
      type.to_s.split('::').map(&:underscore).join '-'
    end

    def parse_trash_param(param)
      type = nil
      if param.to_sym.in? trash_models
        type = param
      else
        modules = param.split('-')
        if modules.count > 1 && modules.all? { |mod| mod.to_sym.in?(trash_modules) || mod.to_sym.in?(trash_models) }
          type = modules.join '/'
        end
      end
      type.camelize.constantize
    end
  end
end
