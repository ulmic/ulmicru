module GenderHelper
  def is_male?
    @sex_detector ||= SexDetector.detector
    @sex_detector.detect(first_name) == 'M'
  end

  def is_female?
    @sex_detector ||= SexDetector.detector
    @sex_detector.detect(first_name) == 'F'
  end
end
