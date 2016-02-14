@AudienceNestedForm = React.createClass
  render: ->
    `<div class="input select required delivery_campaign_audiences_audience_type">
      <label class="select required" for="delivery_campaign_audiences_attributes_0_audience_type">
	<abbr title="required">*</abbr> 
	Audience type
      </label>
      <select class="select required" name="delivery_campaign[audiences_attributes][0][audience_type]" id="delivery_campaign_audiences_attributes_0_audience_type">
	<option value=""></option>
        <option value="team">На команду</option>
        <option selected="selected" value="users">Все пользователи сайта</option>
        <option value="contact_emails">На все имеющиеся почтовые адреса</option>
        <option value="event_registrations">Участников мероприятия</option>
      </select>
    </div>`
