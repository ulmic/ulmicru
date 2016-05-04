class RedirectRuleDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{url} -> #{redirect_to}"
  end

  def self.collections
    [ :active ]
  end
end
