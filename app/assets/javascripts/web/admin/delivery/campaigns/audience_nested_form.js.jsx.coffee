selectAudienceInstance = (component) ->
  if component.state.audience_type == 'team'
    label = I18n.t("web.admin.delivery.campaigns.form.select_team")
  else if 'event_registrations'
    label = I18n.t("web.admin.delivery.campaigns.form.select_event_registrations")
  switch component.state.audience_type
    when 'users', 'contact_emails'
      ``
    when 'team', 'event_registrations'
      `<div className="input select required">
	<label className="select required" for="delivery_campaign_audiences_select">
	  <abbr title="required">*</abbr> 
	  {label}
	</label>
	<select onChange={this.editForm} className="select required" name="delivery_campaign[audiences_instance_select]" id="delivery_campaign_audiences_select">
	</select>
      </div>`

current_audience_type_value = ->
  $('#delivery_campaign_audiences_attributes_0_audience_type').val()

@AudienceNestedForm = React.createClass
  getInitialState: ->
    { audience_type: 'users' }
  editForm: ->
    this.setState { audience_type: current_audience_type_value() }
  componentDidUpdate: ->
    $('select').addClass('form-control')
  componentDidMount: ->
    this.setState { audience_type: current_audience_type_value() }
  render: ->
    options = []
    $(this.props.audience_types).each ->
      options.push `<option value={this[1]}>{this[0]}</option>`
    `<div>
      <div className="input select required delivery_campaign_audiences_audience_type">
	<label className="select required" for="delivery_campaign_audiences_attributes_0_audience_type">
	  <abbr title="required">*</abbr> 
	  Audience type
	</label>
	<select onChange={this.editForm} className="select required" name="delivery_campaign[audiences_attributes][0][audience_type]" id="delivery_campaign_audiences_attributes_0_audience_type">
	  {options}
	</select>
      </div>
      {selectAudienceInstance(this)}
    </div>`
