class ProjectDecorator < ApplicationDecorator
  delegate_all

  def name
    object.title
  end
end
