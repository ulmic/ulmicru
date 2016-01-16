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

current_vote_state = (component) ->
  $.ajax {
    url: Routes.api_users_votes_path(vote: {
                                             target_type: $('.vote').data('targetType')
                                             target_id: $('.vote').data('targetId')
                                           })
    method: 'GET'
    dataType: 'JSON'
    success: (data) ->
      difference = data.difference
      switch difference
        when 1
          state = 'like'
        when -1
          state = 'dislike'
        else
          state = 'none'
      component.setState {
                           vote: state
                           likes: data.results.likes
                           dislikes: data.results.dislikes
                         }
    error: ->
      component.setState { vote: 'none' }
  }

@Vote = React.createClass
  getInitialState: ->
    {
      vote: 'none'
      likes: 0
      dislikes: 0
    }
  componentDidMount: ->
    component = this
    target_id = $('.vote').data('targetId')
    setInterval (->
      if $('.vote').data('targetId') != target_id
        current_vote_state(component)
        target_id = $('.vote').data 'targetId'
    ), 500
  vote: (type) ->
    voting this, type
  render: ->
    if this.props.mode == 'view_results'
      results_display = 'block'
    else
      results_display = 'none'
    like_classes = "fa fa-thumbs-up fa-3x #{'checked' if this.state.vote == 'like'}"
    dislike_classes = "fa fa-thumbs-down fa-3x #{'checked' if this.state.vote == 'dislike'}"
    `<div onMouseUp={this.updateStates} className='vote' data-target-type={this.props.target_type}
                                                         data-target-id={this.props.target_id}>
      <i onClick={this.vote.bind(null, 'like')} className={like_classes} style={{float: 'left'}}></i>
      <span className='vote_results' style={{display: results_display, float: 'left'}}>
        {this.state.likes}
      </span>
      <i onClick={this.vote.bind(null, 'dislike')} className={dislike_classes} style={{float: 'left'}}></i>
      <span className='vote_results' style={{display: results_display, float: 'left'}}>
        {this.state.dislikes}
      </span>
    </div>`
