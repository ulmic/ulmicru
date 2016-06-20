import React from 'react'
import AudienceForm from './audience_form'

var shortAudienceTypes = function(component) {
  if (component.props.audiences.length + component.state.newFieldsCount > 1) {
    var audienceTypes = []
    $(component.props.audience_types).each(function() {
      if ($.inArray(this[1], ['users', 'contact_emails']) == -1) {
        audienceTypes.push(this)
      }
    })
    return audienceTypes
  } else {
    return component.props.audience_types
  }
}

var newForms = function(component) {
  var forms = []
  var audienceTypes = shortAudienceTypes(component)
  for (var i = 0; i < component.state.newFieldsCount; i++) {
    forms.push(<div className='row-fluid'>
		  <AudienceForm key={`new-${i}`} index={i + component.props.audiences.length}
                              campaign_id={component.props.campaign_id}
                              audience_types={audienceTypes} />
		</div>)
  }
  return forms
}

var existedForms = function(component) {
  var forms = []
  for (var i = 1; i < component.props.audiences.length; i++) {
    var index = i + component.props.audiences.length
    var audienceTypes = shortAudienceTypes(component)
    forms.push(<div className='row-fluid'>
		  <AudienceForm key={`existed-${i}`} audience={component.props.audiences[i]}
                              index={index}
                              campaign_id={component.props.campaign_id}
                              audience_types={audienceTypes} />
               </div>)
  }
  return forms
}

var addNewFieldsButton = function(component) {
  return(<a href='#' key='add-new-field-button' className='btn btn-warning add-new-fields' onClick={component.addFields} >
    {I18n.t('web.admin.delivery.campaigns.form.add_audience')}
  </a>)
}

var checkAddNewFieldButtonStatus = function(component) {
  if ($('.delivery_campaign_audiences_audience_type').length == 1) {
    var mainAudienceType = $('#delivery_campaign_audiences_attributes_0_audience_type').val()
    switch (mainAudienceType) {
      case 'event_registrations':
      case 'team':
        $('.add-new-fields').prop('display', 'block')
        return
      case 'contact_emails':
      case 'users':
        $('.add-new-fields').prop('display', 'none')
    }
  }
}
  

class AudienceNestedForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = { newFieldsCount: 0 }
    this.addFields = this.addFields.bind(this)
  }
  addFields() {
    this.setState({ newFieldsCount: this.state.newFieldsCount + 1 })
  }
  render() {
    return(<div>
      {existedForms(this)}
      {newForms(this)}
      {addNewFieldsButton(this)}
    </div>)
  }
}

export default AudienceNestedForm
