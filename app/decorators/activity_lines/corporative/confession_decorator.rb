class ActivityLines::Corporative::ConfessionDecorator < ApplicationDecorator
  delegate_all

  decorates_association :member

  def title
    "#{object.member.decorate.short_name} | #{I18n.t("enumerize.activity_lines/corporative/confession.nomination.#{object.nomination}")}"
  end

  def short_name
    object.member.decorate.short_name
  end

  def self.collections
    [ :confirmed, :unviewed, :on_vote, :declined ]
  end

  alias name short_name
end
