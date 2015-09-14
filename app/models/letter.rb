class Letter < ActiveRecord::Base
  belongs_to :executor, class_name: 'User'

  include LetterScopes

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :sended
    state :removed

    event :send_letter do
      transition all => :sended
    end

    event :remove do
      transition all => :removed
    end
  end
end
