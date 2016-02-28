hr = (component) ->
  `<hr/>` unless component.state.comments.length == 0

@CommentsField = React.createClass
  loadComments: ->
    $.ajax {
      url: Routes.api_comments_path()
      data: {
        record_type: this.props.record_type
        record_id: this.props.record_id
      }
      dataType: 'JSON'
      success: ((data) ->
        this.setState { comments: data }
      ).bind this
    }
  getInitialState: ->
    { comments: [] }
  componentDidMount: ->
    this.loadComments()
  handleSubmit: (text) ->
    component = this
    $.ajax {
      url: Routes.api_comments_path()
      type: 'POST'
      data: {
        comment: {
          text: text
          record_id: this.props.record_id
          record_type: this.props.record_type
        }
      }
      dataType: 'JSON'
      success:( ->
        component.loadComments()
      ).bind component
      error:(->
        alert 'error'
      ).bind component
    }
  render: ->
    `<div>
      <CommentsList comments={this.state.comments}
		    currentUser={this.props.current_user}/>
      {hr(this)}
      <CommentsForm currentUser={this.props.current_user}
		    currentUserAvatar={this.props.current_user_avatar}
		    handleSubmit={this.handleSubmit}
		    authenticity_token={this.props.authenticity_token}/>
    </div>`
