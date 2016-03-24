class BannerDecorator < ApplicationDecorator
  delegate_all

  def name
    link
  end

  def small_thumb
    vertical.present? ? vertical.small : horizontal.small
  end

  def self.collections
    [ :actual, :active, :unviewed, :removed ]
  end
end
