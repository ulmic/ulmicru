class ArticleValidator < ActiveModel::Validator
  def validate(record)
    if !(record.category.present? && record.category.is_last)
      record.errors[:base] << "This node can't be used as articles storage" 
    end
  end
end
