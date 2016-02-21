selectAudienceInstance = (component) ->
  if component.state.audience_type == 'team'
    label = I18n.t("web.admin.delivery.campaigns.form.select_team")
  else if 'event_registrations'
    label = I18n.t("web.admin.delivery.campaigns.form.select_event_registrations")
  switch component.state.audience_type
    when 'users', 'contact_emails'
      ``
    when 'team', 'event_registrations'
      index = component.props.index
      audienceInstanceSelectId = "delivery_campaign_audiences_attributes_#{index}_audience_id"
      audienceInstanceSelectName = "delivery_campaign[audiences_attributes][#{index}][audience_id]"
      `<div className="input select required col-md-5">
	<label className="select required" for={audienceInstanceSelectId}>
	  <abbr title="required">* </abbr>
	  {label}
	</label>
	<select onChange={component.editId} className="select select2-audience required" 
		name={audienceInstanceSelectName} 
		id={audienceInstanceSelectId}>
	</select>
      </div>`

current_audience_type_value = (component)->
  $("#delivery_campaign_audiences_attributes_#{component.props.index}_audience_type").val()

current_audience_id_value = ->
  $('#delivery_campaign_audiences_select').val()

@AudienceForm = React.createClass
  getInitialState: ->
    {
      audience_type: 'users'
      visible: true
    }
  editForm: ->
    this.setState { audience_type: current_audience_type_value() }
  editId: ->
    this.setState { audience_id: current_audience_id_value() }
  componentDidUpdate: ->
    $('select').addClass('form-control')
    url = ''
    switch this.state.audience_type
      when 'team'
        url = Routes.api_admin_teams_path()
      when 'event_registrations'
        url = Routes.api_admin_events_path()
    $('.select2-audience').select2 {
      ajax: {
        url: url
        data: (term, page) ->
          {
            q: term
            page: page
          }
        dataType: 'json'
        delay: 250
        processResults: (data) ->
          audience_results = []
          $(data).each ->
            audience_results.push {
              id: @.id
              text: @.title
            }
          {
            results: audience_results
          }
      }
      minimumInputLength: 2
    }
  componentDidMount: ->
    this.setState { audience_type: current_audience_type_value(this) }
  removeField: (e) ->
    e.preventDefault()
    this.setState { visible: false }
  restoreField: (e) ->
    e.preventDefault()
    this.setState { visible: true }
  render: ->
    options = []
    index = this.props.index
    $(this.props.audience_types).each ->
      options.push `<option value={this[1]}>{this[0]}</option>`
    campaignIdInputName = "delivery_campaign[audiences_attributes][#{index}][campaign_id]"
    campaignIdInputId = "delivery_campaign_audiences_attributes_#{index}_campaign_id"
    audienceTypeSelectName = "delivery_campaign[audiences_attributes][#{index}][audience_type]"
    audienceTypeSelectId = "delivery_campaign_audiences_attributes_#{index}_audience_type"
    if this.state.visible
      `<div>
	<div className="input select required delivery_campaign_audiences_audience_type col-md-5">
	  <label className="select required" for={audienceTypeSelectId}>
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
      </div>`
    else
      `<a onClick={this.restoreField} href='#' className='btn btn-primary'>{I18n.t('helpers.links.restore')}</a>`
