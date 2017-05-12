class BannerDecorator < ApplicationDecorator
  delegate_all

  def name
    object.link
  end

  def small_thumb
    (object.vertical || object.horizontal).small
  end
end
