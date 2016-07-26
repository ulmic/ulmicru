class BannerDecorator < ApplicationDecorator
  delegate_all

  def name
    object.link
  end

  def small_thumb
    (object.vertical || object.horizontal).small
  end

  def self.collections
    [ :actual, :active, :unviewed, :removed ]
  end
end
