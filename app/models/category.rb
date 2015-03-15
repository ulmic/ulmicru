class Category < ActiveRecord::Base
  belongs_to :parent, class_name: 'Category'
  has_many   :articles,   class_name: 'Article'

  validates :name,      presence: true
  validates :parent_id, presence: false
end
