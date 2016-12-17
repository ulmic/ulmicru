class Oauth::AppDecorator < ApplicationDecorator
  delegate_all

  def self.collections
    [:unviewed, :active, :removed]
  end
end
