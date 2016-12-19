require 'scopes_rails/state_machine/scopes'

module MemberScopes
  extend ActiveSupport::Concern

  included do
    scope :presented, -> { where('member_state != \'removed\' AND member_state != \'not_member\'').order('ticket ASC') }
    scope :confirmed, -> { where(member_state: :confirmed).where.not(ticket: nil, state: :unavailable).order('ticket DESC') }
    scope :declined, -> { where(member_state: :declined).where.not(state: :unavailable).order('ticket DESC') }
    scope :removed, -> { where(member_state: :removed).order('ticket DESC') }
    scope :unavailable, -> { where(state: :unavailable).order('ticket ASC') }
    scope :tag_available, -> { where.not(state: :removed).where(member_state: :confirmed) }
    scope :without_confessions, -> {
      where.not(id: ::ActivityLines::Corporative::Confession.confirmed.map(&:member_id).uniq)
    }
    scope :cannot_get_confession, -> { where('join_date > ?', DateTime.now - 3.month) }
    scope :with_debut, -> { where(id: ::ActivityLines::Corporative::Confession.confirmed.where(nomination: :debut).map(&:member_id)) }
    scope :without_debut, -> {
      where.not(id: with_debut) + Member.without_confessions - Member.cannot_get_confession
    }
    scope :with_number_one, -> { where(id: ::ActivityLines::Corporative::Confession.confirmed.where(nomination: :number_one).map(&:member_id)) }
    scope :without_number_one, -> {
      where.not(id: with_number_one) + Member.without_confessions - Member.cannot_get_confession
    }
    scope :need_to_review, -> { where(member_state: :unviewed, type: 'Member').where.not(state: :unavailable).order('id ASC') }
  end
end
