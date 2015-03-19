class Category < ActiveRecord::Base
  after_initialize :initial_load
  before_save :set_parent_to_no_last
  after_destroy :set_parent_to_nil

  belongs_to :parent,     class_name: 'Category'
  has_many   :articles

  validates :name,      presence: true
  validates :parent_id, presence: false
  validates :is_last,   presence: false

  include CategoryScopes

  def self.get_by_parent_id(category_id, all_tree = false)
    Category.where(parent_id: category_id).where.not(state: :removed)
  end

  def self.get_tree_by_category(category)
    if(category.state != "removed")
      if(category.present? && category.is_last)
        return {
          childs: nil,
          category_name: category.name,
          id: category.id
        }
      else
        category_hash = Hash.new
        Category.get_by_parent_id(category.id).map do |c|
          category_hash[:category_name] = category.name
          category_hash[:id] = category.id
          if category_hash[:childs].present?
            category_hash[:childs] << get_tree_by_category(c)
          else
            category_hash[:childs] = [get_tree_by_category(c)]
          end
        end
        category_hash
      end
    else
      Hash.new
    end
  end

  def self.get_tree
    Category.roots.map do |c|
      Category.get_tree_by_category(c)
    end 
  end

  state_machine initial: :unviewed do
    state :unviewed
    state :removed

    event :remove do
      transition all => :removed
    end
    event :restore do
      transition :removed => :unviewed
    end
  end

  private
  def initial_load
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

  def set_parent_to_nil
    Category.get_by_parent_id(self.id).each do |child|
       child.parent_id = nil
       child.save
     end
  end
end
