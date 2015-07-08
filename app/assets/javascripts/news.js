$(function(){
	$('.news_show .slider').slick({
	    infinite: true,
	    slidesToShow: 1,
	    slidesToScroll: 1,
        prevArrow: $('.news_show .slider-arrow.left'),
        nextArrow: $('.news_show .slider-arrow.right')
	});
});
