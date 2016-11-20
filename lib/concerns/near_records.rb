module NearRecords
  extend ActiveSupport::Concern

  def previous(record_id, on:)
    record_id ||= id
    scopes = on.is_a?(Array) ? on : [on]
    collection = scopes.reduce(self) do |col, scope|
      col.send scope
    end
    index = collection.map(&:id).index(record_id)
    unless index == 0
      collection[index - 1]
    end
  end

  def next(record_id = nil, on:)
    record_id ||= id
    scopes = on.is_a?(Array) ? on : [on]
    collection = scopes.reduce(self) do |col, scope|
      col.send scope
    end
    index = collection.map(&:id).index(record_id)
    unless index == collection.count - 1
      collection[index + 1]
    end
  end
end
