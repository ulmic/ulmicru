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
  audienceTypes = shortAudienceTypes component
  for i in [0...component.state.newFieldsCount]
    forms.push `<div className='row-fluid'>
		  <AudienceForm index={i + component.props.audiences.length}
                              campaign_id={component.props.campaign_id}
                              audience_types={audienceTypes} />
		</div>`
  forms

existedForms = (component) ->
  forms = []
  for i in [1..component.props.audiences.length]
    index = i + component.props.audiences.length
    audienceTypes = shortAudienceTypes component
    forms.push `<div className='row-fluid'>
		  <AudienceForm audience={component.props.audiences[i]}
                              index={index}
                              campaign_id={component.props.campaign_id}
                              audience_types={audienceTypes} />
		</div>`
  forms

addNewFieldsButton = (component) ->
  `<a href='#' className='btn btn-warning add-new-fields' onClick={component.addFields} >
    {I18n.t('web.admin.delivery.campaigns.form.add_audience')}
  </a>`

checkAddNewFieldButtonStatus = (component) ->
  if $('.delivery_campaign_audiences_audience_type').length == 1
    mainAudienceType = $('#delivery_campaign_audiences_attributes_0_audience_type').val()
    switch mainAudienceType
      when 'team', 'event_registrations'
        $('.add-new-fields').prop 'display', 'block'
      when 'users', 'contact_emails'
        $('.add-new-fields').prop 'display', 'none'
  

@AudienceNestedForm = React.createClass
  getInitialState: ->
    {
      newFieldsCount: 0
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
