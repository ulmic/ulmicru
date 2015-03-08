class ActivityLine < ActiveRecord::Base
  extend Enumerize
  has_one :user, as: :creator

  enumerize :type, in: [:central_program, :local_project, :corporate_project]
end
