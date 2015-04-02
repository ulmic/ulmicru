module Concerns
  module DurationManagment
    def duration
      unless end_date == :for_now
        if begin_date.year == end_date.to_datetime.year
          duration = "#{I18n.t('helpers.in')} #{begin_date.year} #{I18n.t('helpers.year')}"
        else
          duration = "#{I18n.t('helpers.from')} #{begin_date.year} #{I18n.t('helpers.until')} #{end_date.to_datetime.year} #{I18n.t('helpers.years')}"
        end
      end
      duration
    end
    def begin_before_end_date
      if begin_date.present? && end_date.present?
        unless begin_date <= end_date.to_datetime
          errors.add(:end_date, I18n.t('validations.errors.end_date_must_be_after_begin_date'))
        end
      end
    end
  end

end
