fillCommentTemplate = (component, comment, currentUser) ->
  removeButton = ''
  if currentUser.id == comment.user.id
    removeButton = `<div className='columns small-1'>
      <div className='remove' onClick={component.props.removeComment.bind(null, comment.id)}>
	<i className='fa fa-remove'></i>
      </div>
    </div>`
  `<div className='row comment'>
    <div className='small-2 columns'>
      <img src={comment.user.avatar} />
    </div>
    <div className='columns small-9 text'>
      <h4>
	{comment.user.short_name}
      </h4>
      {comment.text}
    </div>
    {removeButton}
  </div>`

@CommentsList = React.createClass
  removeComment: (id) ->
    this.props.removeComment id
  render: ->
    comments = []
    currentUser = this.props.currentUser
    component = this
    $(this.props.comments).each ->
      comments.push fillCommentTemplate component, @, currentUser
    `<div className='comments-list'>
      {comments}
    </div>`
