voting = (component, vote) ->
  if component.state.vote == 'none'
    method = 'POST'
  else
    if component.state.vote == vote
      method = 'DELETE'
    else
      method = 'PATCH'

  if vote == 'like'
    difference = 1
  else if vote == 'dislike'
    difference = -1

  $.ajax {
    url: Routes.api_users_votes_path()
    method: method
    data: {
      vote: {
        # NOTE: используем jQuery, потому что target_type и target_id могут изменяться вне React класса. Антипаттерн :(
        # FIXME исправить при полном переходе на React
        target_type: $('.vote').data('targetType')
        target_id: $('.vote').data('targetId')
        difference: difference
      }
    }
    success: ->
      if component.state.vote == vote
        component.setState { vote: 'none' }
      else
        component.setState { vote: vote }
    error: ->
      alert 'error'
  }

@Vote = React.createClass
  getInitialState: ->
    { vote: 'none' }
  vote: (type) ->
    voting this, type
  render: ->
    `<div className='vote' data-target-type={this.props.target_type}
                             data-target-id={this.props.target_id}>
      <i onClick={this.vote.bind(null, 'like')} className='fa fa-thumbs-up fa-3x'></i>
      <i onClick={this.vote.bind(null, 'dislike')} className='fa fa-thumbs-down fa-3x'></i>
    </div>`
