import React from 'react'

var init_results = function(component, vote, data) {
  component.setState({
    vote: vote,
    likes: data.results.likes,
    dislikes: data.results.dislikes,
  })
}

var voting = function(component, vote) {
  if (component.state.vote == 'none') {
    method = 'POST'
  } else {
    if (component.state.vote == vote) {
      method = 'DELETE'
    } else {
      method = 'PATCH'
    }
  }
  if (vote == 'like') {
    difference = 1
  } else if (vote == 'dislike') {
    difference = -1
  }

  $.ajax({
    url: Routes.api_users_votes_path(),
    method: method,
    data: {
      vote: {
        // NOTE: используем jQuery, потому что target_type и target_id могут изменяться вне React класса. Антипаттерн :(
        // FIXME исправить при полном переходе на React
        target_type: $('.vote').data('targetType'),
        target_id: $('.vote').data('targetId'),
        difference: difference
      }
    },
    success: () => {
      if (component.state.vote == vote) {
        component.setState({ vote: 'none' })
        difference = -1
      } else {
        difference = 1
        if (component.state.vote == 'like' && vote == 'dislike' || component.state.vote == 'dislike' && vote == 'like') {
          other_difference = 1
        }
        component.setState({ vote: vote })
      }
      likes = component.state.likes
      dislikes = component.state.dislikes
      switch (vote) {
        case 'like':
          component.setState({ likes: likes + difference })
          if (!(other_difference == void(0))) {
            component.setState({ dislikes: dislikes - other_difference })
          }
          break
        case 'dislike':
          component.setState({ dislikes: dislikes + difference })
          if (!(other_difference == void(0))) {
            component.setState({ likes: likes - other_difference })
          }
          break
      }
    },
    error: () => {
      alert('error')
    }
  })
}

var current_vote_state = function(component) {
  target_type = $('.vote').data('targetType')
  target_id = $('.vote').data('targetId')
  $.ajax({
    url: Routes.api_users_votes_path(vote: {
                                             target_type: target_type,
                                             target_id: target_id
                                           }),
    method: 'GET',
    dataType: 'JSON',
    success: (data) => {
      if (data.difference == void(0)) {
        state = 'none'
      } else {
        switch (data.difference) {
          case 1:
            state = 'like'
            break
          case -1:
            state = 'dislike'
            break
        }
      }
      init_results(component, state, data)
    }
  })
}

class Vote extends React.Component {
  constructor(props) {
    super(props)
    thos.state = {
      vote: 'none',
      likes: 0,
      dislikes: 0
    }
  }
  componentDidMount() {
    let target_id = $('.vote').data('targetId')
    setInterval(() => {
      if ($('.vote').data('targetId') != target_id) {
        current_vote_state(this)
        target_id = $('.vote').data('targetId')
      }
    }, 100)
  }
  vote(type) {
    voting(this, type)
  }
  render() {
    if (this.props.mode == 'view_results') {
      results_display = 'block'
    } else {
      results_display = 'none'
    }
    let like_checked = ''
    if (this.state.vote == 'like') {
      like_checked = 'checked'
    }
    let dislike_checked = ''
    if (this.state.vote == 'dislike') {
      dislike_checked = 'checked'
    }
    like_classes = `fa fa-thumbs-up fa-3x ${like_checked}`
    dislike_classes = `fa fa-thumbs-down fa-3x ${dislike_checked}`
    return (
      <div onMouseUp={this.updateStates} className='vote' data-target-type={this.props.target_type}
                                                          data-target-id={this.props.target_id}>
        <i onClick={this.vote.bind(null, 'like')} className={like_classes} style={{float: 'left'}}></i>
        <span className='vote_results' style={{display: results_display, float: 'left'}}>
          {this.state.likes}
        </span>
        <i onClick={this.vote.bind(null, 'dislike')} className={dislike_classes} style={{float: 'left'}}></i>
        <span className='vote_results' style={{display: results_display, float: 'left'}}>
          {this.state.dislikes}
        </span>
      </div>)
  }
}
