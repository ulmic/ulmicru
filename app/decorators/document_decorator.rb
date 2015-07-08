class DocumentDecorator < ApplicationDecorator
  delegate_all

  def name
    title
  end
end
