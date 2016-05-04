class RedirectRuleDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{object.url} -> #{object.redirect_to}"
  end

  def self.collections
    [ :active ]
  end
end
