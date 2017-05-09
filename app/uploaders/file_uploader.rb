# encoding: utf-8

class FileUploader < ApplicationUploader
  def extension_white_list
    %w(pdf doc docx xls csv xlsx)
  end
end
