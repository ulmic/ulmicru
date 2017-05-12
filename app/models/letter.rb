class Letter < ActiveRecord::Base
  belongs_to :executor, class_name: 'User'

  validates :subdivision_code, presence: true
  validates :number, presence: true
  validates :send_date, presence: true
  validates :receiver, presence: true
  validates :title, presence: true
  validates :list_number, presence: true
  validates :state, presence: true
  validates :file, presence: true

  mount_uploader :file, FileUploader

  state_machine :state, initial: :sended do
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

  include StateMachine::Scopes

  scope :unviewed, -> { where(state: :unviewed).order('number DESC') }
  scope :sended, -> { where(state: :sended).order('number DESC') }
  scope :presented, -> { where.not(state: :removed) }
  scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }

  include PgSearch
  pg_search_scope :search_everywhere, against: [:title, :receiver, :number, :executor_name]

  def self.collections
    [ :sended, :unviewed ]
  end
end
