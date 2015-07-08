module Concerns
  module AvatarManagment
    def default_avatar
      sex = SexDetector.detector.detect first_name
      if type == 'Member'
        if sex == 'M'
          ActionController::Base.helpers.asset_path 'default-mic-man-icon.png'
        else
          ActionController::Base.helpers.asset_path 'default-mic-woman-icon.png'
        end
      else
        if sex == 'M'
          ActionController::Base.helpers.asset_path 'default-man-icon.png'
        else
          ActionController::Base.helpers.asset_path 'default-woman-icon.png'
        end
      end
    end
  end
end
