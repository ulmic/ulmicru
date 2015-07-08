module SexDetector
  def self.detector
    @detector ||= RussianSex::Detector.new
  end
end
