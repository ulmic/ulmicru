# encoding: utf-8

class PhotoUploader < ApplicationUploader
  include ImageDefaults

  def default_url
    ActionController::Base.helpers.asset_path("images/default_news_photo.png")
  end

  version :medium do
    process :resize_to_fill => [400, 400]
  end

  version :mobile_thumb do
    process :resize_to_fill => [225, 150]
  end

  version :small do
    process :resize_to_fill => [100, 100]
  end

  version :event_main_page_version do
    process :resize_to_fill => [340, 212, 'North']
  end

  attr_reader :width, :height

  before :cache, :capture_size

  def capture_size(file)
    if version_name.blank?
      if file.path.nil?
        img = ::MiniMagick::Image::read(file.file)
        @width = img[:width]
        @height = img[:height]
      else
        @width, @height = `identify -format "%wx %h" #{file.path}`.split(/x/).map{|dim| dim.to_i }
      end
    end
  end
end
