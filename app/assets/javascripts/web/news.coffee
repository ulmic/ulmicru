$ ->
  $('article.news-info img').each ->
    image = this
    $('<img/>').attr('src', $(this).attr('src')).load ->
      pic_real_width = this.width
      pic_real_height = this.height
      dimension = pic_real_width / pic_real_height
      $(image).height $(image).width() / dimension
