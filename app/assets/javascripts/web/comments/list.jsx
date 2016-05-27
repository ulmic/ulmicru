import React from 'react'

var fillCommentTemplate = function(component, comment, currentUser) {
  var removeButton = ''
  if (currentUser.id == comment.user.id) {
    removeButton = <div className='columns small-1'>
      <div className='remove' onClick={component.props.removeComment.bind(null, comment.id)}>
	<i className='fa fa-remove'></i>
      </div>
    </div>
  }
  return(<div className='row comment'>
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
         </div>)
}

class CommentsList extends React.Component {
  constructor(props) {
    super(props)
    this.removeComment = this.removeComment.bind(this)
  }
  removeComment(id) {
    this.props.removeComment(id)
  }
  render() {
    var comments = []
    var currentUser = this.props.currentUser
    var component = this
    $(this.props.comments).each(function() {
      comments.push(fillCommentTemplate(component, this, currentUser))
    })
    return(<div className='comments-list'>
              {comments}
           </div>)
  }
}

export default CommentsList
