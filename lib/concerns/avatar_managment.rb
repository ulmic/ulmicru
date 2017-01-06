module AvatarManagment
  def default_avatar(target = false)
    @sex_detector ||= SexDetector.detector
    sex = @sex_detector.detect first_name
    image_url = if type == 'Member'
                  if sex == 'M'
                    'default-mic-man-icon.png'
                  else
                    'default-mic-woman-icon.png'
                  end
                else
                  if sex == 'M'
                    'default-man-icon.png'
                  else
                    'default-woman-icon.png'
                  end
                end
    (target == :image_url) ? image_url : ActionController::Base.helpers.asset_path(image_url)
  end
end
