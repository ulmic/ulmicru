module GenderHelper
  def is_male?
    @sex_detector ||= SexDetector.detector
    @sex_detector.detect(first_name.strip) == 'M'
  end

  def is_female?
    @sex_detector ||= SexDetector.detector
    @sex_detector.detect(first_name.strip) == 'F'
  end

  def self.detect_gender(first_name)
    @sex_detector ||= SexDetector.detector
    @sex_detector.detect(first_name.strip) == 'F' ? :female : :male
  end
end
