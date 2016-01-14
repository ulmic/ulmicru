voting = (component) ->
  $.ajax {
  }

@Vote = React.createClass
  getInitialState: ->
    { vote: 'none' }
  like: ->
    this.setState { vote: 'like' }
    voting this
  dislike: ->
    this.setState { vote: 'dislike' }
    voting this
  render: ->
    `<div className = 'vote' data-target-type={this.props.target_type}
                             data-target-id={this.props.target_id}>
      <i onClick = {this.like} className = 'fa fa-thumbs-up fa-3x'></i>
      <i className = 'fa fa-thumbs-down fa-3x'></i>
    </div>`
