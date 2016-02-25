module TagsHelper
  def tags
    if self.class.superclass == Team
      Tag.where(target_id: id, target_type: self.class.superclass)
    else
      Tag.where(target_id: id, target_type: model_name.name)
    end
  end
end
