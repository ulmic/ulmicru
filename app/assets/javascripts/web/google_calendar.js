function googleCalendarEvent(client_id, action, event, element) {
	var CLIENT_ID = client_id;
	var SCOPES = ["https://www.googleapis.com/auth/calendar"];
	var registration = $(element).data('registration');

	function handleAuthResult(authResult) {
		if (authResult && !authResult.error) {
			gapi.client.load('calendar', 'v3', query);
		} else {
			modalShow('Error authenticating in Google');
		}
	}

	function saveGoogleCalendarEventId(google_event_id) {
		$.ajax({
			method: 'PATCH',
			url: Routes.api_events_registration_path(registration['id']),
			dataType: 'text',
			data: {
				event_registration: {
					google_calendar_event_id: google_event_id
				}
			},
			success: function(response) {
				$(element).data('registration', {id: registration.id, google_calendar_event_id: google_event_id});
			},
			error: function(textStatus, errorThrown){
				//FIXME адекватный алерт
				alert('Произошла ошибка');
			}
		});
	}

	function query() {
		var request = {};
		// if (typeof event['calendar_id'] !== "undefined" && event['calendar_id'] !== null) {
		// 	calendar_id = event['calendar_id'];
		// } else {
		var calendar_id = 'primary';
		// };
		switch (action) {
			case 'add':
				request = gapi.client.calendar.events.insert({
					"calendarId": calendar_id,
					"start": {
						"dateTime": event['begin_date']
					},
					"end": {
						"dateTime": event['end_date']
					},
					'reminders': {
						'useDefault': false,
						'overrides': [
							{'method': 'email', 'minutes': 24 * 60 * 3},
							{'method': 'email', 'minutes': 24 * 60},
							{'method': 'popup', 'minutes': 24 * 60 * 3},
							{'method': 'popup', 'minutes': 24 * 60}
						]
					},
					"description": event['description'],
					"summary": event['title']
				});
				request.execute(function(resp) {
					saveGoogleCalendarEventId(resp['id']);
				});
				break;
			case 'delete':
				request = gapi.client.calendar.events.delete({
					"calendarId": calendar_id,
					"eventId": registration['google_calendar_event_id']
				});
				request.execute(function(resp) {
				});
				break;
			default:
				alert("Wrong Google request");
		}

	}

	function checkAuth() {
		gapi.auth.authorize(
			{
				'client_id': CLIENT_ID,
				'scope': SCOPES.join(' '),
				'immediate': true
			}, handleAuthResult);
	}

	gapi.auth.authorize(
		{client_id: CLIENT_ID, scope: SCOPES, immediate: false, authUser: 1},
		handleAuthResult);
		return true;
}
