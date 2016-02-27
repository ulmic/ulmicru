@CommentsField = React.createClass
  render: ->
    `<div>
      <CommentsList comment={this.props.comments}
		    currentUser={this.props.current_user}/>
      <CommentsForm currentUser={this.props.current_user} />
    </div>`
