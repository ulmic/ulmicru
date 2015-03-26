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
  end
end
