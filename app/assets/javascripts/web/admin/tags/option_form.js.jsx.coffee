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
      <input value='News' className='hidden' type='hidden' name='tag[record_type]' id='tag_record_type' value={component.props.recordType} />
    </div>
    <div className='input hidden tag_record_id'>
      <input value={component.props.record.id} className='hidden' type='hidden' name='tag[record_id]' id='tag_record_id' />
    </div>
    <div className='input hidden tag_target_type'>
      <input className='hidden' type='hidden' name='tag[target_type]' id='tag_target_type' value={component.props.targetType} />
    </div>
  </div>`

stringInputDisplayState = (state) ->
  if state == 'string'
    return 'block'
  else
    return 'none'

@TagOptionForm = React.createClass
  getInitialState: ->
    {
      stringInputVisible: 'hidden'
    }
  stringTagForm: (e) ->
    e.preventDefault()
    @.setState { stringInputVisible: 'visible' }
  render: ->
    display = formDisplay @
    stringInputDisplay = stringInputDisplayState @.state.stringInputVisible
    `<form className='tag_form' action={Routes.admin_tags_path()} data-remote='true' method='post' style={{display}}>
      {hiddenInputs(this)}
      <div className='input select optional tag_target_id'>
        <select className='select optional select2-tags' name='tag[target_id]' id='tag_target_id'>
        </select>
      </div>
      <div style={{display: stringInputDisplay}} className='input tag_text'>
        <input className='string form-control' name='tag[text]' id='tag_text' />
      </div>
      <input type='submit' name='commit' value='Добавить тег'  className='button btn btn-xs btn-success' />
      <a onClick={this.stringTagForm} className='btn btn-xs btn-warning' id='add_new_string_tag' href='#'>Создать новый</a>
    </form>`
