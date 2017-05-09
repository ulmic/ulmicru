class Token < ActiveRecord::Base
  belongs_to :record, polymorphic: true

  after_create :generate_content

  include StateMachine::Scopes
  scope :subscriptions, -> { where record_type: 'Subscription' }

  private

  def generate_content
    update_attributes content: SecureHelper.generate_token
  end
end
