import React from 'react'

class StandaloneCommentsForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = { text: '', formDisplay: 'show' }
    this.onTextChange = this.onTextChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }
  handleSubmit(e) {
    e.preventDefault()
    let record_id = this.props.record_id
    if (record_id == void(0) || record_id == null) {
      record_id = $('#targetIdStore').data('targetId')
    }
    var component = this
    $.ajax({
      url: Routes.api_comments_path(),
      type: 'POST',
      data: {
        comment: {
          text: text,
          record_id: record_id,
          record_type: this.props.record_type
        }
      },
      dataType: 'JSON',
      success: (function() {
        alert('Ваш комментарий оставлен')
        this.setState({ text: '', formDisplay: 'hide' })
      }).bind(component),
      error: (function() {
        alert('error')
      }).bind(component)
    })
  }
  onTextChange(e) {
    this.setState({ text: e.target.value })
  }
  render() {
    let formDisplay
    let messageDisplay
    if (this.state.formDisplay == 'show') {
      formDisplay = { display: 'block' }
      messageDisplay = { display: 'none' }
    } else {
      formDisplay = { display: 'none' }
      messageDisplay = { display: 'block' }
    }

    return(<div>
      <div className='comment-form'>
        <h4>
          {I18n.t('web.comments.form.add_comment')}
        </h4>
        <div className='row'>
          <div className='small-2 columns avatar'>
            <img src={this.props.currentUserAvatar} />
          </div>
          <div className='small-10 columns end'>
            <form noValidate="novalidate" className="simple_form new_comment" id="new_comment"
                  action="/api/comments" acceptCharset="UTF-8" method="post"
                  onSubmit={this.handleSubmit} style={{formDisplay}}>
              <input name="utf8" type="hidden" value="&#x2713;" />
              <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
              <div className="input text required comment_text">
                <textarea className="text required" placeholder={I18n.t('web.comments.form.write_your_comment')}
                          name="comment[text]" id="comment_text"
                          onChange={this.onTextChange} value={this.state.text}>
                </textarea>
              </div>
              <input type="submit" name="commit" value={I18n.t('helpers.submit')} className="button" />
            </form>
            <span style={{messageDisplay}}>
              Ваш комментарий отправлен
            </span>
            <i className="fa-spinner fa fa-spin"/>
          </div>
        </div>
      </div>
    </div>)
  }
}

export default StandaloneCommentsForm
