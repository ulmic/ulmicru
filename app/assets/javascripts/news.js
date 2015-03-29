$(function() {
		var $main_photo = $('.news-content .main-photo');
		if ($main_photo.size() > 0) {
				var ratio =  $main_photo.width() / $main_photo.find('img').width();
				if (ratio > 2) {
						var author_width = ($main_photo.find('img').width() * 100) / $main_photo.width();
						author_width += 2.5; // margin left
						$('.news-content').addClass('floated-main-photo');

						$("#news-show .date-author").css({"margin-left": author_width + "%"})
				}
		}

});
