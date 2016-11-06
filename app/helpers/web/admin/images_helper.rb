module Web::Admin::ImagesHelper
  def new_redirect_rule_by_image_path(image)
    new_admin_redirect_rule_path(redirect_rule: {
      redirect_to: @image_form.file.url,
      status: :moved_permanently
    })
  end
end
