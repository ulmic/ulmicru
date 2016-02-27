class CommentCollectionDecorator < DefaultCollectionDecorator
  def with_users
    with :id, :text, 
	user: { 
		avatar: -> { user.small_avatar_url },
		short_name: -> { user.short_name }
	      } 
  end
end
