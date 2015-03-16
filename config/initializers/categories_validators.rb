class CategoryValidator < ActiveModel::Validator
  def validate(record)
    if record.parent.present? && Category.find(record.parent_id).articles.present?
      record.errors[:parent_id] << "This node can be used as articles storage only.
      To resolve it just delete all news in parent category: #{record.parent.name}" 
    end
  end
end
