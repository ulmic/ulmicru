class Protocol < ActiveRecord::Base
  mount_uploader :scan, PhotoUploader

  belongs_to :team

  validates :record_id, uniqueness: { scope: :record_type }

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
  scope :not_filled, -> { (where(document_id: nil) + where(scan: nil)).uniq }

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
