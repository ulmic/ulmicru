module Concerns
  module SexManagment
    def is_man?
      @detector = RussianSex::Detector.new
      sex = @detector.detect first_name
      sex == 'M'
    end
  end
end
