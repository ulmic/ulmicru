# encoding: utf-8

class FileUploader < ApplicationUploader
  def extension_white_list
    %w(pdf)
  end
end
