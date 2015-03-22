class ActivityLine < ActiveRecord::Base
  extend Enumerize
  belongs_to :creator, class_name: User

  enumerize :activity_type, in: [:central_program, :local_project, :corporate_project]

  state_machine :state, initial: :active do
    state :active
    state :removed

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition removed: :active
    end
  end
end
