formDisplay = (component) ->
  if component.props.tagType == 'none'
    return 'none'
  else
    return 'block'

hiddenInputs = (component) ->
  `<div>
    <div className='input hidden tag_tag_type'>
      <input className='hidden' type='hidden' name='tag[tag_type]' id='tag_tag_type' value={component.props.tagType} />
    </div>
    <div className='input hidden tag_record_type'>
      <input value='News' className='hidden' type='hidden' name='tag[record_type]' id='tag_record_type' value={component.props.recordType.replace(/^./, component.props.recordType[0].toUpperCase())} />
    </div>
    <div className='input hidden tag_record_id'>
      <input value={component.props.record.id} className='hidden' type='hidden' name='tag[record_id]' id='tag_record_id' />
    </div>
    <div className='input hidden tag_target_type'>
      <input className='hidden' type='hidden' name='tag[target_type]' id='tag_target_type' value={component.props.targetType} />
    </div>
  </div>`

stringInputDisplayState = (component) ->
  if component.props.tagType == 'string' && component.state.stringInputVisible == 'visible'
    return 'block'
  else
    return 'none'

tagSelectDisplay = (targetType, type, component) ->
  if targetType == type && component.state.stringInputVisible == 'hidden'
    return 'block'
  else
    return 'none'

stringSelectDisplay = (component) ->
  tagSelectDisplay component.props.tagType, 'string', component

memberSelectDisplay = (component) ->
  tagSelectDisplay component.props.targetType, 'member', component

@TagOptionForm = React.createClass
  getInitialState: ->
    {
      stringInputVisible: 'hidden'
      targetId: ''
    }
  changeValue: (inputId) ->
    this.setState { targetId: $("##{inputId}").val() }
  stringTagForm: (e) ->
    e.preventDefault()
    if this.state.stringInputVisible == 'visible'
      @.setState { stringInputVisible: 'hidden' }
    else
      @.setState { stringInputVisible: 'visible' }
  render: ->
    display = formDisplay @
    `<form className='tag_form' action={Routes.api_admin_tags_path()} onSubmit={this.props.onTagSubmit} data-remote='true' method='post' style={{display}}>
      {hiddenInputs(this)}
      <div className='input select optional tag_text' style={{display: stringSelectDisplay(this)}}>
        <input className='select optional select2-tags' name='tag[text]' id='tag_text' data-type='string'/>
      </div>
      <div className='input text' style={{display: stringInputDisplayState(this)}}>
        <input className='form-control input text' name='tag[text]' id='tag_text' />
      </div>
      <div className='input select optional tag_target_id' style={{display: memberSelectDisplay(this)}}>
        <input className='select optional select2-tags' name='tag[target_id]' id='tag_target_id' data-type='member'/>
      </div>
      <input type='submit' name='commit' value='Добавить тег' className='button btn btn-xs btn-success' />
      <a onClick={this.stringTagForm} className='btn btn-xs btn-warning' id='add_new_string_tag' href='#'>Создать новый</a>
    </form>`
