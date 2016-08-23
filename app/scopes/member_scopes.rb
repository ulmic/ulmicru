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
      where.not(id: ::ActivityLines::Corporative::Confession.all.map(&:member_id).uniq)
    }
    scope :cannot_get_confession, -> { where('join_date > ?', DateTime.now - 3.month) }
    scope :without_debut, -> {
      includes(:confessions).references(:confessions).where('activity_lines_corporative_confessions.nomination != \'debut\'') + Member.without_confessions - Member.cannot_get_confession
    }
    scope :without_number_one, -> {
      includes(:confessions).references(:confessions).where('activity_lines_corporative_confessions.nomination != \'number_one\'') + Member.without_confessions - Member.cannot_get_confession
    }
    scope :need_to_review, -> { where(member_state: :unviewed, type: 'Member').where.not(state: :unavailable).order('id ASC') }
  end
end
