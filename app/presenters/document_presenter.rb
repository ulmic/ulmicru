class DocumentPresenter < ApplicationPresenter
  attributes :file, :title, :state, :created_at, :updated_at

  def file
    object.file.url
  end
end
