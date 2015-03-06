class ActivityLine < ActiveRecord::Base
  has_one :user, as: :creator

  enumerize :type, in: [:central_program, :local_project, :corporate_project]
end
