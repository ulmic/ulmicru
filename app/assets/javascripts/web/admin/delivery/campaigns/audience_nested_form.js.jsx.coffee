@AudienceNestedForm = React.createClass
  getInitialState: ->
    { audience_type: 'users' }
  render: ->
    options = []
    $(this.props.audience_types).each ->
      options.push `<option value={this[1]}>{this[0]}</option>`
    `<div className="input select required delivery_campaign_audiences_audience_type">
      <label className="select required" for="delivery_campaign_audiences_attributes_0_audience_type">
	<abbr title="required">*</abbr> 
	Audience type
      </label>
      <select className="select required" name="delivery_campaign[audiences_attributes][0][audience_type]" id="delivery_campaign_audiences_attributes_0_audience_type">
	{options}
      </select>
    </div>`
