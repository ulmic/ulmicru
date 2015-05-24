// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require slick
//= require bootstrap-sprockets
//= require jquery_ujs
//= require moment
//= require moment/ru
//= require bootstrap-datetimepicker
//= require pickers
//= require js-routes
//= require active_form
//= require i18n_setup
//= require placeholders
//= require localities
//= require events
//= require web/members
//= require web/events
//= require news
//= require foundation
//= require select2
//= require web/users/account
//= require jasny-bootstrap

$(document).foundation();
$(function(){
  $(document).foundation('tab', 'reflow');
	$('.main-slider .slider-items').slick({
	  centerMode: true,
    autoplay: true,
    autoplaySpeed: 6000,
    speed: 800,
	  centerPadding: '22%',
	  slidesToShow: 1,
    responsive: [
      {
        breakpoint: 1100,
        settings: {
          centerPadding: '20%',
        }
      }
    ],
    prevArrow: $('.main-slider .left-arrow'),
    nextArrow: $('.main-slider .right-arrow')
	});
	$('.news-slider').slick({
	  infinite: false,
	  slidesToShow: 5,
	  slidesToScroll: 5,
    prevArrow: $('.news .slider-arrows>.left-arrow'),
    nextArrow: $('.news .slider-arrows>.right-arrow')
	});
});

$(document).ready(function() {
    // почему не тэг <a> вместо?
  $('.link').click(function() {
    location.href = $(this).attr('data-href');
  });
  $('select.select2').select2();

  $('.slider-link').click(function() {
      if ($(this).hasClass("slick-active")) {
          location.href = $(this).attr('data-href');
      }
  });
  $('.blank').prop('target', '_blank');
});
