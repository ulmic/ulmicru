class Article < ActiveRecord::Base
  validates :title,   presence: true
  validates :body,    presence: true
  validates :user_id, presence: true
  validates :view,    presence: false
end
