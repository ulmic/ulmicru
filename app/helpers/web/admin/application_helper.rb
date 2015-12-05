module Web::Admin::ApplicationHelper
  include Localities
  include Places

  def state_color(item)
    if item.methods.include? :unviewed?
      :success if item.unviewed?
    end
  end

  def tab_title(model_class, tab, count)
    model = model_class.name.underscore
    model = :team if model.include? 'team'
    "#{t("state_machines.#{model}.state.states.#{tab}").pluralize(:ru)} / #{count}"
  end

  def search_tab_title(count)
    "#{t("helpers.found")} / #{count}"
  end

  def searchable_model?(model_class)
    model_class.methods.include? :search_everywhere
  end

  def enumerize_locales_hash(model, attribute)
    I18n.t("enumerize.#{model.name.underscore}.#{attribute}").invert
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

  def model_class
    request[:controller].split('/')[2..-1].join('/').singularize.camelize.constantize
  end

  def to_path(constant)
    constant = Team if constant.to_s.include? 'Team'
    constant.name.underscore.gsub '/', '_'
  end
end
