class Projects::ApplicationRecordForm < SimpleDelegator
  attr_reader :record

  attr_accessor :project_id, :version, :title, :record_type

  delegate :model_name, to: :record
  delegate :to_key, to: :record
  delegate :save, to: :record

  def initialize(record, params = {})
    @record = record
    params.permit! unless params == {}
    record.properties ||= {}
    params.each do |key, value|
      record.properties.merge! key => value
    end
    record.title = title
    record.project_id = project_id
    record.version = version
    record.record_type = record_type
  end
end
