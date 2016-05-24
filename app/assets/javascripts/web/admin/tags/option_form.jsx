import React from 'react'

var formDisplay = function(component) {
  if (component.props.tagType == 'none') {
    return 'none'
  } else {
    return 'block'
  }
}

var init_select2 = function(component) {
  $('.select2-tags').each(function() {
    var dataType;
    if (component.props.tagType == 'string') {
      dataType = 'string'
    } else {
      dataType = component.props.targetType
    }
    if ($(this).hasClass(dataType)) {
      var url = ''
      switch(dataType) {
        case 'string':
          url = Routes.api_admin_tags_path()
          break
        case 'member':
          url = Routes.api_admin_members_path()
          break
        case 'event':
          url = Routes.api_admin_events_path()
          break
        case 'team':
          url = Routes.api_admin_teams_path()
          break
        case 'activity_line':
          url = Routes.api_admin_activity_lines_path()
          break
      }
      $(this).select2({
        ajax: {
          url: url,
          data: function(term, page) {
            return {
              q: term,
              page: page
            }
          },
          dataType: 'json',
          delay: 250,
          processResults: function(data) {
            var tags_results = []
            $(data).each(function() {
              switch(dataType) {
                case 'string':
                  tags_results.push({
                    id: this.text,
                    text: this.text
                  })
                  break
                case 'member':
                  tags_results.push({
                    id: this.id,
                    text: `${this.ticket} | ${this.first_name} ${this.last_name}`
                  })
                  break
                case 'event':
                case 'team':
                case 'activity_line':
                  tags_results.push({
                    id: this.id,
                    text: this.title
                  })
                  break
              }
            })
            return({
              results: tags_results
            })
          }
        },
        minimumInputLength: 2
      })
    }
  })
}

var formDisplay = function(component) {
  if (component.props.tagType == 'none') {
    return 'none'
  } else {
    return 'block'
  }
}

var targetTypeInput = function(component) {
  if (!(component.props.targetType == 'none')) {
    var targetType = component.props.targetType.camelize()
    return(<div className='input hidden tag_target_type'>
        <input className='hidden' type='hidden' name='tag[target_type]' id='tag_target_type' value={targetType} />
      </div>)
  }
}

var hiddenInputs = function(component) {
  var recordType = component.props.recordType.camelize()
  return(<div>
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
  </div>)
}

var tagSelectDisplay = function(targetType, type, component) {
  if (targetType == type) {
    return 'block'
  } else {
    return 'none'
  }
}

var linkSelect = function(type) {
  var classes = `select optional select2-tags ${type}`
  return(<div className='input select optional tag_target_id'>
    <select className={classes} name='tag[target_id]' id='tag_target_id' data-type={type} style={{width: '100%'}}/>
  </div>)
}

var getSelectToView = function(component) {
  switch(component.props.tagType) {
    case 'string':
      if (component.state.stringInputVisible == 'hidden') {
        return(<div className='input select optional tag_text'>
          <select className='select optional select2-tags string' name='tag[text]' id='tag_text' data-type='string' style={{width: '100%'}}/>
        </div>)
      }
    case 'link':
      return linkSelect(component.props.targetType)
  }
}

var newStringTagInput = function(component) {
  if ((component.props.tagType == 'string') && (component.state.stringInputVisible == 'visible')) {
    return(<div className='input text'>
      <input className='form-control input text' name='tag[text]' id='tag_text' />
    </div>)
  }
}

var newStringTagButton = function(component) {
  if (component.props.tagType == 'string') {
    return(<a onClick={component.stringTagForm.bind(component)} className='btn btn-xs btn-warning' id='add_new_string_tag' href='#'>Создать новый</a>)
  }
}

class TagOptionForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      stringInputVisible: 'hidden',
      targetId: ''
    }
  }
  changeValue(inputId) {
    this.setState({ targetId: $('#' + inputId).val() })
  }
  stringTagForm(e) {
    e.preventDefault()
    if (this.state.stringInputVisible == 'visible') {
      this.setState({ stringInputVisible: 'hidden' })
    } else {
      this.setState({ stringInputVisible: 'visible' })
    }
  }
  componentDidUpdate() {
    init_select2(this)
    var component = this
    $('.tag_form').on('ajax:success', component.props.onTagSubmit)
  }
  render() {
    var display = formDisplay(this)
    return(<form className='tag_form' action={Routes.api_admin_tags_path()} onSubmit={this.props.onTagSubmit} data-remote='true' method='post' style={{display}}>
      {hiddenInputs(this)}
      {getSelectToView(this)}
      {newStringTagInput(this)}
      <input type='submit' name='commit' value='Добавить тег' className='button btn btn-xs btn-success' />
      {newStringTagButton(this)}
    </form>)
  }
}

export default TagOptionForm
