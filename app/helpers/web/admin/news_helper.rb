module Web::Admin::NewsHelper
  def new_redirect_rule_by_photo_path(photo)
    new_admin_redirect_rule_path(redirect_rule: {
      redirect_to: photo.to_s,
      status: :moved_permanently
    })
  end
end
