class VideoDecorator < ApplicationDecorator
  delegate_all

  def name
    object.title
  end

  def self.collections
    [ :active, :removed ]
  end
end
