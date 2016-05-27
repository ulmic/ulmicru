import React from 'react'
import AudienceNestedForm from './audience_nested_form'

var selectAudienceInstance = function(component) {
  if (component.state.audience_type == 'team') {
    label = I18n.t("web.admin.delivery.campaigns.form.select_team")
  } else if (component.state.audience_type == 'event_registrations') {
    label = I18n.t("web.admin.delivery.campaigns.form.select_event_registrations")
  }
  switch(component.state.audience_type) {
    case 'users':
    case 'contact_emails':
      return ''
    case 'event_registrations':
    case 'team':
      index = component.props.index
      audienceInstanceSelectId = `delivery_campaign_audiences_attributes_${index}_audience_id`
      audienceInstanceSelectName = `delivery_campaign[audiences_attributes][${index}][audience_id]`
      return(<div className="input select required col-md-5">
         <label className="select required" for={audienceInstanceSelectId}>
           <abbr title="required">* </abbr>
           {label}
         </label>
         <select onChange={component.editId} className="select select2-audience required" 
                 name={audienceInstanceSelectName} 
                 id={audienceInstanceSelectId}>
         </select>
      </div>)
  }
}

var current_audience_type_value = function(component) {
  return $(`#delivery_campagn_audiences_attributes_${component.props.index}_audience_type`).val()
}

var current_audience_id_value = function() {
  return $('#delivery_campaign_audiences_select').val()
}

class AudienceForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      audience_type: 'users',
      visible: true
    }
  }
  editForm() {
    this.setState({ audience_type: current_audience_type_value() })
  }
  editId() {
    this.setState({ audience_id: current_audience_id_value() })
  }
  componentDidUpdate() {
    $('select').addClass('form-control')
    var url = ''
    switch (this.state.audience_type) {
      case 'team':
        url = Routes.api_admin_teams_path()
        return 
      case 'event_registrations':
        url = Routes.api_admin_events_path()
        return
    }
    $('.select2-audience').select2({
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
          audience_results = []
          $(data).each(function() {
            audience_results.push({
              id: this.id,
              text: this.title
            })
          })
          return { results: audience_results}
        }
      },
      minimumInputLength: 2
    })
  }
  componentDidMount() {
    this.setState({ audience_type: current_audience_type_value(this) })
  }
  removeField(e) {
    e.preventDefault()
    this.setState({ visible: false })
  }
  restoreField(e) {
    e.preventDefault()
    this.setState({ visible: true })
  }
  render() {
    var options = []
    var index = this.props.index
    $(this.props.audience_types).each(function() {
      options.push(<option value={this[1]}>{this[0]}</option>)
    })
    var campaignIdInputName = `delivery_campaign[audiences_attributes][${index}][campaign_id]`
    var campaignIdInputId = `delivery_campaign_audiences_attributes_${index}_campaign_id`
    var audienceTypeSelectName = `delivery_campaign[audiences_attributes][${index}][audience_type]`
    var audienceTypeSelectId = `delivery_campaign_audiences_attributes_${index}_audience_type`
    if (this.state.visible) {
      return(<div>
	<div className="input select required delivery_campaign_audiences_audience_type col-md-5">
	  <label className="select required" htmlFor={audienceTypeSelectId}>
	    <abbr title="required">* </abbr>
	    {I18n.t('activerecord.attributes.delivery/audience.audience_type')}
	  </label>
	  <select onChange={this.editForm} className="select required" 
		  name={audienceTypeSelectName}
		  id={audienceTypeSelectId}>
	    {options}
	  </select>
	</div>
	<input type="hidden" name={campaignIdInputName}
			     id={campaignIdInputId}
			     value={this.props.campaign_id} />
	{selectAudienceInstance(this)}
	<div className='col-md-2'>
	  <a onClick={this.removeField} href='#' style={{'margin-top': '22px', 'margin-bottom': '22px'}} className='btn btn-danger'>X</a>
	</div>
      </div>)
    } else {
      return(<a onClick={this.restoreField} href='#' className='btn btn-primary'>{I18n.t('helpers.links.restore')}</a>)
    }
  }
}

export default AudienceForm
