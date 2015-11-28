init_select2 = ->
  to_text = (instance, type) ->
    switch type
      when 'string'
        instance.text
      when 'member'
        "#{instance.ticket} | #{instance.first_name} #{instance.last_name}"

  $('.select2-tags').each ->
    dataType = $(@).data('type')
    url = ''
    switch dataType
      when 'string'
        url = Routes.api_admin_tags_path()
      when 'member'
        url = Routes.api_admin_members_path()
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
            tags_results.push {
              id: @.text
              text: to_text(@, dataType)
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
  if targetType == type
    return 'block'
  else
    return 'none'

getSelectToView = (component) ->
  switch component.props.tagType
    when 'string'
      `<div className='input select optional tag_text'>
        <input className='select optional select2-tags' name='tag[text]' id='tag_text' data-type='string'/>
      </div>`
    when 'link'
      switch component.props.targetType
        when 'member'
          `<div className='input select optional tag_target_id'>
            <input className='select optional select2-tags' name='tag[target_id]' id='tag_target_id' data-type='member'/>
          </div>`

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
    init_select2()
  render: ->
    display = formDisplay @
    `<form className='tag_form' action={Routes.api_admin_tags_path()} onSubmit={this.props.onTagSubmit} data-remote='true' method='post' style={{display}}>
      {hiddenInputs(this)}
      {getSelectToView(this)}
      <div className='input text' style={{display: stringInputDisplayState(this)}}>
        <input className='form-control input text' name='tag[text]' id='tag_text' />
      </div>
      <input type='submit' name='commit' value='Добавить тег' className='button btn btn-xs btn-success' />
      <a onClick={this.stringTagForm} className='btn btn-xs btn-warning' id='add_new_string_tag' href='#'>Создать новый</a>
    </form>`
