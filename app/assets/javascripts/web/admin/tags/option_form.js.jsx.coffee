formDisplay = (component) ->
  if component.props.tagType == 'none'
    return 'none'
  else
    return 'block'

@TagOptionForm = React.createClass
  render: ->
    display = formDisplay @
    `<form className='tag_form' action={Routes.admin_tags_path()} data-remote='true' method='post' style={{display}}>
      <div className='input hidden tag_tag_type'>
        <input className='hidden' type='hidden' name='tag[tag_type]' id='tag_tag_type' value={this.props.tagType} />
      </div>
      <div className='input hidden tag_record_typee'>
        <input value='News' className='hidden' type='hidden' name='tag[record_type]' id='tag_record_type' value={this.props.recordType} />
      </div>
      <div className='input hidden tag_record_id'>
        <input value={this.props.record.id} className='hidden' type='hidden' name='tag[record_id]' id='tag_record_id' />
      </div>
      <div className='input hidden tag_target_type'>
        <input className='hidden' type='hidden' name='tag[target_type]' id='tag_target_type' value={this.props.targetType} />
      </div>
      <div className='input select optional tag_target_id'>
        <select className='select optional select2-tags' name='tag[target_id]' id='tag_target_id'>
        </select>
      </div>
      <div className='input hidden tag_text'>
        <input className='hidden' type='hidden' name='tag[text]' id='tag_text' />
      </div>
      <input type='submit' name='commit' value='Добавить тег'  className='button btn btn-xs btn-success' />
      <a className='btn btn-xs btn-warning' id='add_new_string_tag' href='#'>Создать новый</a>
    </form>`
