module Concerns
  module AvatarManagment
    def default_avatar
      @detector = RussianSex::Detector.new
      sex = @detector.detect first_name
      if sex == 'M'
        ActionController::Base.helpers.asset_path 'default-man-icon.png'
      else
        ActionController::Base.helpers.asset_path '/images/default-woman-icon.png'
      end
    end
  end
end
