class Token < ActiveRecord::Base
  belongs_to :record, polymorphic: true

  after_create :generate_content

  private

  def generate_content
    update_attributes content: SecureHelper.generate_token
  end
end
