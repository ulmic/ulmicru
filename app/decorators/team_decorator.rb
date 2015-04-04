class TeamDecorator < Draper::Decorator
  delegate_all

  def short_description
    "#{ActionController::Base.helpers.strip_tags(model.description)[0..50]}..."
  end
end
