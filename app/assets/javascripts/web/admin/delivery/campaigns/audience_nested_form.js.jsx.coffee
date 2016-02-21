shortAudienceTypes = (component) ->
  if component.props.audiences.length + component.state.newFieldsCount > 1
    audienceTypes = []
    $(component.props.audience_types).each ->
      if $.inArray(@[1], ['users', 'contact_emails']) == -1
	audienceTypes.push @
    audienceTypes
  else
    component.props.audience_types

newForms = (component) ->
  forms = []
  audienceTypes = shortAudienceTypes component.props.audience_types
  for i in [0...component.state.newFieldsCount]
    forms.push `<AudienceForm index={i + component.props.audiences.length}
                              campaign_id={component.props.campaign_id}
                              audience_types={audienceTypes} />`
  forms

existedForms = (component) ->
  forms = []
  for i in [1..component.props.audiences.length]
    index = i + component.props.audiences.length - 2
    audienceTypes = shortAudienceTypes component.props.audience_types
    forms.push `<AudienceForm audience={component.props.audiences[i]}
                              index={index}
                              campaign_id={component.props.campaign_id}
                              audience_types={audienceTypes} />`
  forms

addNewFieldsButton = (component) ->
  if component.state.addNewFieldsButtonStatus == 'visible'
    `<a href='#' className='btn btn-warning' onClick={component.addFields} >
      {I18n.t('web.admin.delivery.campaigns.form.add_audience')}
    </a>`

checkAddNewFieldButtonStatus = (component) ->
  if this.state.newFieldsCount + this.props.audiences.length == 1
    mainAudienceType = $('#delivery_campaign_audiences_attributes_0_audience_type').val()
    switch mainAudienceType
      when 'team', 'event_registrations'
        status = 'visible'
      when 'users', 'contact_emails'
        status = 'hidden'
  this.setState { addNewFieldsButtonStatus: status }

@AudienceNestedForm = React.createClass
  getInitialState: ->
    {
      newFieldsCount: 0
      audiences: this.props.audiences
      addNewFieldsButtonStatus: 'visible'
    }
  addFields: (e) ->
    e.preventDefault()
    this.setState { newFieldsCount: this.state.newFieldsCount + 1 }
  render: ->
    `<div>
      {existedForms(this)}
      {newForms(this)}
      {addNewFieldsButton(this)}
    </div>`
