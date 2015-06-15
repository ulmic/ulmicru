module Concerns
  module NearRecords
    def previous(record_id)
      record_id ||= id
      self.where('id < ?', record_id).first
    end
    def next(record_id = nil)
      record_id ||= id
      self.where('id > ?', record_id).last
    end
  end
end
