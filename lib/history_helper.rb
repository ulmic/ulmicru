module HistoryHelper
  def history_events_list
    history_events = YAML.load_file("#{Rails.root}/lib/yaml/history_events.yml").with_indifferent_access[:history]
  end
end
