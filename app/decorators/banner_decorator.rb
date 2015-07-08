class BannerDecorator < ApplicationDecorator
  delegate_all

  def name
    link
  end
end
