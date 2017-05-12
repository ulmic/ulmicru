class RedirectRuleDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{object.old_path} -> #{object.redirect_to}"
  end
end
