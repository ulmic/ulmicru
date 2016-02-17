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
	<label className="select required" for="delivery_campaign_audiences_attributes_0_audience_type">
	  <abbr title="required">* </abbr>
	  {label}
	</label>
	<select onChange={component.editId} className="select select2-audience required" name="delivery_campaign[audiences_attributes][0][audience_id]" id="delivery_campaign_audiences_attributes_0_audience_id">
	</select>
      </div>`

current_audience_type_value = ->
  $('#delivery_campaign_audiences_attributes_0_audience_type').val()

current_audience_id_value = ->
  $('#delivery_campaign_audiences_select').val()

@AudienceForm = React.createClass
  getInitialState: ->
    {
      audience_type: 'users'
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
    this.setState { audience_type: current_audience_type_value() }
  render: ->
    options = []
    $(this.props.audience_types).each ->
      options.push `<option value={this[1]}>{this[0]}</option>`
    `<div>
      <div className="input select required delivery_campaign_audiences_audience_type">
        <label className="select required" for="delivery_campaign_audiences_attributes_0_audience_type">
          <abbr title="required">* </abbr>
          {I18n.t('activerecord.attributes.delivery/audience.audience_type')}
        </label>
        <select onChange={this.editForm} className="select required" name="delivery_campaign[audiences_attributes][0][audience_type]" id="delivery_campaign_audiences_attributes_0_audience_type">
          {options}
        </select>
      </div>
      <input type="hidden" name="delivery_campaign[audiences_attributes][0][campaign_id]"
                           id="delivery_campaign_audiences_attributes_0_campaign_id"
                           value={this.props.campaign_id} />
      {selectAudienceInstance(this)}
    </div>`
