class Projects::ApplicationRecordForm < SimpleDelegator
  attr_reader :record

  delegate :model_name, to: :record
  delegate :to_key, to: :record
  delegate :save, to: :record
  delegate :properties, to: :record

  def initialize(record, params = {})
    @record = record
    params.permit! unless params == {}
  end
end
