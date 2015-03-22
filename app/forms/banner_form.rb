class BannerForm < ActiveForm::Base
  self.main_model = :banner

  attributes :photo, :link, :begin_date, :end_date, required: true
end
