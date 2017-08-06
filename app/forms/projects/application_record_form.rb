class Projects::ApplicationRecordForm < SimpleDelegator
  attr_reader :record

  delegate :model_name, to: :record
  delegate :to_key, to: :record

  def initialize(record)
    @record = record
  end
end
