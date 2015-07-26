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

  def form_after_save?
    referrer = Rails.application.routes.recognize_path request.referrer
    referrer[:controller] == params[:controller] && referrer[:action] == params[:action]
  end

  def object_updated_less_minute_ago?(object)
    ((DateTime.now - object.model.updated_at.to_datetime) * 24 * 60).to_i < 1
  end
end
