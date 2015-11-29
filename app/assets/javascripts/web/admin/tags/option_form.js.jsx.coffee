formDisplay = (component) ->
  if component.props.tagType == 'none'
    return 'none'
  else
    return 'block'

init_select2 = (component) ->
  $('.select2-tags').each ->
    if component.props.tagType == 'string'
      dataType = 'string'
    else
      dataType = component.props.targetType
    if $(this).hasClass dataType
      url = ''
      switch dataType
        when 'string'
          url = Routes.api_admin_tags_path()
        when 'member'
          url = Routes.api_admin_members_path()
        when 'event'
          url = Routes.api_admin_events_path()
        when 'team'
          url = Routes.api_admin_teams_path()
        when 'activity_line'
          url = Routes.api_admin_activity_lines_path()
      $(this).select2 {
        ajax: {
          url: url
          data: (term, page) ->
            {
              q: term
              page: page
            }
          dataType: 'json'
          delay: 250
          results: (data) ->
            tags_results = []
            $(data).each ->
              switch dataType
                when 'string'
                  tags_results.push {
                    id: @.text
                    text: @.text
                  }
                when 'member'
                  tags_results.push {
                    id: @.id
                    text: "#{@.ticket} | #{@.first_name} #{@.last_name}"
                  }
                when 'event', 'team', 'activity_line'
                  tags_results.push {
                    id: @.id
                    text: @.title
                  }
            {
              results: tags_results
            }
        }
        minimumInputLength: 2
        placeholder: $(this).data('prompt')
      }

formDisplay = (component) ->
  if component.props.tagType == 'none'
    return 'none'
  else
    return 'block'

targetTypeInput = (component) ->
  unless component.props.targetType == 'none'
    targetType = component.props.targetType.replace(/(\_\w)/g, (m) -> m[1].toUpperCase())
    targetType = targetType.replace /^./, targetType[0].toUpperCase()
    `<div className='input hidden tag_target_type'>
        <input className='hidden' type='hidden' name='tag[target_type]' id='tag_target_type' value={targetType} />
      </div>`

hiddenInputs = (component) ->
  recordType = component.props.recordType.replace /_/, ''
  recordType = recordType.replace /^./, recordType[0].toUpperCase()
  `<div>
    <div className='input hidden tag_tag_type'>
      <input className='hidden' type='hidden' name='tag[tag_type]' id='tag_tag_type' value={component.props.tagType} />
    </div>
    <div className='input hidden tag_record_type'>
      <input value='News' className='hidden' type='hidden' name='tag[record_type]' id='tag_record_type' value={recordType} />
    </div>
    <div className='input hidden tag_record_id'>
      <input value={component.props.record.id} className='hidden' type='hidden' name='tag[record_id]' id='tag_record_id' />
    </div>
    {targetTypeInput(component)}
  </div>`

stringInputDisplayState = (component) ->
  if component.props.tagType == 'string' && component.state.stringInputVisible == 'visible'
    return 'block'
  else
    return 'none'

tagSelectDisplay = (targetType, type, component) ->
  if targetType == type
    return 'block'
  else
    return 'none'

getSelectToView = (component) ->
  switch component.props.tagType
    when 'string'
      `<div className='input select optional tag_text'>
        <input className='select optional select2-tags string' name='tag[text]' id='tag_text' data-type='string'/>
      </div>`
    when 'link'
      switch component.props.targetType
        when 'member'
          `<div className='input select optional tag_target_id'>
            <input className='select optional select2-tags member' name='tag[target_id]' id='tag_target_id' data-type='member'/>
          </div>`
        when 'event'
          `<div className='input select optional tag_target_id'>
            <input className='select optional select2-tags event' name='tag[target_id]' id='tag_target_id' data-type='event'/>
          </div>`
        when 'team'
          `<div className='input select optional tag_target_id'>
            <input className='select optional select2-tags team' name='tag[target_id]' id='tag_target_id' data-type='team'/>
          </div>`
        when 'activity_line'
          `<div className='input select optional tag_target_id'>
            <input className='select optional select2-tags activity_line' name='tag[target_id]' id='tag_target_id' data-type='activityline'/>
          </div>`

newStringTagInput = (component) ->
  if component.props.tagType == 'string'
    `<div className='input text' style={{display: stringInputDisplayState(component)}}>
      <input className='form-control input text' name='tag[text]' id='tag_text' />
    </div>`

newStringTagButton = (component) ->
  if component.props.tagType == 'string'
    `<a onClick={component.stringTagForm} className='btn btn-xs btn-warning' id='add_new_string_tag' href='#'>Создать новый</a>`

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
  componentDidUpdate: ->
    init_select2 this
    component = this
    $('.tag_form').on 'ajax:success', component.props.onTagSubmit
  render: ->
    display = formDisplay @
    `<form className='tag_form' action={Routes.api_admin_tags_path()} onSubmit={this.props.onTagSubmit} data-remote='true' method='post' style={{display}}>
      {hiddenInputs(this)}
      {getSelectToView(this)}
      {newStringTagInput(this)}
      <input type='submit' name='commit' value='Добавить тег' className='button btn btn-xs btn-success' />
      {newStringTagButton(this)}
    </form>`
