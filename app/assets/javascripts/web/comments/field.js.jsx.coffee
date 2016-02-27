@CommentsField = React.createClass
  getInitialState: ->
    { newComments: [] }
  render: ->
    `<div>
      <CommentsList comments={this.props.comments}
		    currentUser={this.props.current_user}/>
      <CommentsForm currentUser={this.props.current_user} />
    </div>`
