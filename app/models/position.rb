class Position < ActiveRecord::Base
  belongs_to :member

  validate :begin_before_end_date

  include PositionScopes
  include Concerns::DurationManagment

  def begin_before_end_date
    if begin_date.present? && end_date.present?
      unless begin_date <= end_date.to_datetime
        errors.add(:end_date, I18n.t('validations.errors.end_date_must_be_after_begin_date'))
      end
    end
  end
end
