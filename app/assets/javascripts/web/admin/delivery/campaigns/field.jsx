import React from 'react'
import AudienceForm from './form'
import AudiencesList from './list'

var shortAudienceTypes = function(component) {
  if (component.props.audiences.length + component.state.formsCount > 2) {
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
  for (var i = 0; i < component.state.formsCount; i++) {
    forms.push(
      <div className='row-fluid'>
        <AudienceForm key={`form-${i}`} index={i + component.props.audiences.length}
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
    this.state = { formsCount: 0 }
    this.addFields = this.addFields.bind(this)
  }
  addFields() {
    this.setState({ formsCount: this.state.formsCount + 1 })
  }
  render() {
    return(
      <div key='main-div'>
        <AudiencesList audiences={this.props.audiences}/>
        {newForms(this)}
        {addNewFieldsButton(this)}
      </div>)
  }
}

export default AudienceNestedForm
