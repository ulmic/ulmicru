comment = (user, comment) ->
  `<div className='row comment'>
    <div className='small-2 columns'>
      <img src={user.avatar} />
    </div>
    <div className='columns small-9-text'>
      <h4>
	{user.short_name}
      </h4>
    </div>
    <div className='columns small-1'>
      <div className='remove' data-comment-id={comment.id}>
	<i className='fa fa-remove'></i>
      </div>
    </div>
  </div>`

@CommentsList = React.createClass
  render: ->
    comments = []
    $(this.props.comments).each ->
      comments.push comment @.user, @
    `<div className='comments-list'>
      {comments}
    </div>`
