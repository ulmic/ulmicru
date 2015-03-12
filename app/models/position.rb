class Position < ActiveRecord::Base
  belongs_to :member

  validates :title, presence: true
  validates :member_id, presence: true
  validates :begin_date, presence: true
  validates :end_date, presence: true
  validate :begin_before_end_date

  def begin_before_end_date
    if begin_date.present? && end_date.present?
      return if begin_date <= end_date
    end
    errors.add(:end_date, I18n.t('validations.errors.end_date_must_be_after_begin_date'))
  end
end
