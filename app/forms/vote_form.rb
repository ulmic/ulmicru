class VoteForm < ApplicationReform
  properties :user_id, :target_id, :target_type, :difference
  property :difference, sync: lambda { |identificator| model.difference = difference_count(identificator)  }

  validates :user_id, presence: true
  validates :target_id, presence: true
  validates :target_type, presence: true
  validates :difference, presence: true

  private

  def difference_count(identificator)
    case identificator
    when 'like'
      1
    when 'dislike'
      -1
    end
  end
end
