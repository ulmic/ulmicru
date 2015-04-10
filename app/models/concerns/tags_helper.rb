module Concerns
  module TagsHelper
    def tags
      Tag.where(target_id: id, target_type: model_name.name)
    end
  end
end
