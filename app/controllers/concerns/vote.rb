module Concerns
  module Vote
    def difference_count(identificator)
      case identificator
      when 'like'
	1
      when 'dislike'
	-1
      end
    end
  end
end
