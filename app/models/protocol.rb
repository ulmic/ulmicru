class Protocol < ActiveRecord::Base
  mount_uploader :scan, PhotoUploader

  belongs_to :team
  has_many :attenders, class_name: 'Protocol::Attender'
  has_many :absents, class_name: 'Protocol::Absent'

  validates :record_id, uniqueness: { scope: :record_type },
                        allow_blank: true,
                        allow_nil: true

  state_machine :state, initial: :active do
    state :active
    state :removed

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition all => :active
    end
  end

  include StateMachine::Scopes
  scope :without_attenders, -> do
    joins('LEFT JOIN protocol_attenders ON protocols.id = protocol_attenders.protocol_id')
    .where('protocol_attenders.protocol_id IS NULL')
  end
  scope :without_absents, -> do
    joins('LEFT JOIN protocol_absents ON protocols.id = protocol_absents.protocol_id')
    .where('protocol_absents.protocol_id IS NULL')
  end
  scope :not_filled, -> { (where(document_id: nil) + where(scan: nil) + without_attenders).uniq } 

  include PgSearch
  pg_search_scope :search_everywhere, against: [ :title, :document_id ],
    associated_against: { team: [ :title ] }

  # NOTE we don't need document association
  def document
    ::Document.find document_id if document_id.present?
  end

  def self.collections
    [ :active, :removed ]
  end
end
