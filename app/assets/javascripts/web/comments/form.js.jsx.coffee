@CommentsForm = React.createClass
  getInitialState: ->
    { text: '' }
  handleSubmit: (e) ->
    e.preventDefault()
    this.props.handleSubmit this.state.text
    this.setState { text: '' }
  onTextChange: (e) ->
    this.setState { text: e.target.value }
  render: ->
    `<div>
      <div className='comment-form'>
	<h4>
	  Добавить комментарий
	</h4>
	<div className='row'>
	  <div className='small-2 columns avatar'>
	    <img src={this.props.currentUserAvatar} />
	  </div>
	  <div className='small-10 columns end'>
	    <form noValidate="novalidate" className="simple_form new_comment" id="new_comment" 
		  action="/api/comments" acceptCharset="UTF-8" method="post" 
		  onSubmit={this.handleSubmit}>
	      <input name="utf8" type="hidden" value="&#x2713;" />      
	      <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
	      <div className="input text required comment_text">
		<textarea className="text required" placeholder="Введите свой комментарий..." 
			  name="comment[text]" id="comment_text"
			  onChange={this.onTextChange} value={this.state.text}>
		</textarea>
	      </div>
	      <input type="submit" name="commit" value="Отправить" className="button" />
	    </form>
	  </div>
	</div>
      </div>
    </div>`
