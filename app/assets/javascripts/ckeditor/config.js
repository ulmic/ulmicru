CKEDITOR.editorConfig = function (config) {
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";
  config.extraPlugins = 'youtube,oembed';
  var csrf_token = $('meta[name=csrf-token]').attr('content'),
      csrf_param = $('meta[name=csrf-param]').attr('content');

  if (csrf_param !== undefined && csrf_token !== undefined) {
    config.filebrowserImageUploadUrl += "?" + csrf_param + "=" + encodeURIComponent(csrf_token)
  }
}
