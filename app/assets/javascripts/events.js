$(function() {
		$("#event-lead-more-info").on('click', function() {
				$(this).find('.hide-all').toggleClass('hide');
				$(this).find('.show-all').toggleClass('hide');

				$(".more-lead-info").toggleClass('viewed');
				$(".event-container").toggleClass('more-info-viewed');
				return false;
		});
});
