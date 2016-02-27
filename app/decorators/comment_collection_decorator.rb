class CommentCollectionDecorator < Draper::CollectionDecorator
  def with_users
    object.decorate.map do |comment|
      { 
	id: comment.id, 
	text: comment.text, 
	user: { 
		avatar: comment.user.small_avatar_url,
		short_name: comment.user.short_name
	      }
      }
    end
  end
end
