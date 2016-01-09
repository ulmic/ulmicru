class Document < ActiveRecord::Base
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :news

  mount_uploader :file, FileUploader

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :active
    state :removed

    event :approve do
      transition all => :active
    end

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition all => :unviewed
    end
  end

  include DocumentScopes
end
