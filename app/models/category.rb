class Category < ActiveRecord::Base
  after_initialize :init
  before_save :set_parent_to_no_last

  belongs_to :parent,     class_name: 'Category'
  has_many   :categorys,   class_name: 'category'

  validates :name,      presence: true
  validates :parent_id, presence: false
  validates :is_last,   presence: false

  include CategoryScopes

  def self.get_by_parent_id(category_id)
    Category.where(parent_id: category_id)
  end

  def self.get_tree_by_category(category)
    if(category.present? && category.is_last)
      return {
        category.name.to_s => nil
      }
    else
      category_hash = Hash.new
      Category.get_by_parent_id(category.id).map do |c|
        if category_hash[category.name].present?
          category_hash[category.name] << get_tree_by_category(c)
        else
          category_hash[category.name] = [get_tree_by_category(c)]
        end
      end
      category_hash
    end
  end

  def self.get_tree
    Category.roots.map do |c|
      Category.get_tree_by_category(c)
    end 
  end

  private
  def init
    self.is_last = true if  self.is_last == nil
  end

  def set_parent_to_no_last
    if self.parent.present?
      category = self.parent
      category.is_last =  false
      category_form = CategoryForm.new category
      category_form.save
    end
  end
end
