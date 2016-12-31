import React from 'react';
import CommentsList from './list'
import CommentsForm from './form'

var hr = function(component) {
  if (!(component.state.comments == null)) {
    return <hr/>
  }
}

class CommentsField extends React.Component {
  constructor(props) {
    super(props)
    this.state = { 
      comments: [],
      loading: false
    }
    this.loadComments = this.loadComments.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
    this.handleRemove = this.handleRemove.bind(this)
  }
  loadComments() {
    this.setState({ loading: true })
    $.ajax({
      url: Routes.api_comments_path(),
      data: {
        record_type: this.props.record_type,
        record_id: this.props.record_id
      },
      dataType: 'JSON',
      success: (function (data) {
        this.setState({ comments: data, loading: false })
      }).bind(this)
    })
  }
  componentDidMount() {
    this.loadComments()
  }
  handleSubmit(text) {
    this.setState({ loading: true })
    var component = this
    $.ajax({
      url: Routes.api_comments_path(),
      type: 'POST',
      data: {
        comment: {
          text: text,
          record_id: this.props.record_id,
          record_type: this.props.record_type
        }
      },
      dataType: 'JSON',
      success: (function() {
        component.loadComments()
      }).bind(component),
      error: (function() {
        component.setState({ loading: false })
        alert('error')
      }).bind(component)
    })
  }
  handleRemove(id) {
    var component = this
    $.ajax({
      url: Routes.api_comment_path(id),
      method: 'DELETE',
      success: (function () {
        component.loadComments()
      }).bind(component),
      error: (function() {
        component.loadComments()
      }).bind(component)
    })
  }
  render() {
    return(<div>
        <CommentsList comments={this.state.comments}
                      currentUser={this.props.current_user}
                      removeComment={this.handleRemove}/>
        {hr(this)}
        <CommentsForm currentUser={this.props.current_user}
                      currentUserAvatar={this.props.current_user_avatar}
                      handleSubmit={this.handleSubmit}
                      authenticity_token={this.props.authenticity_token}
                      spinnerDisplay={this.state.loading}/>
      </div>)
  }
}

export default CommentsField
