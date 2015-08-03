class BannerForm < ApplicationForm
  self.main_model = :banner

  attributes :link, :begin_date, :end_date, required: true
  attributes :vertical, :horizontal
end
