module Concerns
  module SexManagment
    def is_man?
      sex = SexDetector.detector.detect first_name
      sex == 'M'
    end
  end
end
