module Web::Admin::ApplicationHelper
  include Localities
  include Places

  def state_color(item)
    if item.methods.include? :unviewed?
      :success if item.unviewed?
    end
  end

  def tab_title(model_class, tab, count)
    "#{t("state_machines.#{model_class.name.downcase}.state.states.#{tab}").pluralize(:ru)} / #{count}"
  end

  def enumerize_locales_hash(model, attribute)
    I18n.t("enumerize.#{model.name.underscore.gsub('/', '.')}.#{attribute}").invert
  end

  def record_path(record)
    send "#{record.class.name.underscore}_path", record
  end
end
