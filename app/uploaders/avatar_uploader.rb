# encoding: utf-8

class AvatarUploader < ApplicationUploader

  include ImageDefaults

  def default_url(email = "default@email.com")
    #ActionController::Base.helpers.asset_path("images/default_avatar.png")
    hash = Digest::SHA256.hexdigest email
    url  = "http://www.gravatar.com/avatar/#{hash}.png"
  end

  version :medium do
    process :resize_to_fill => [400, 400, 'North']
  end

  version :small do
    process :resize_to_fill => [100, 100, 'North']
  end

  version :profile do
    process :resize_to_fill => [440, 600, 'Center']
  end
end
