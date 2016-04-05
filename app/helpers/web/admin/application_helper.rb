module Web::Admin::ApplicationHelper
  include Localities
  include Places
  include Concerns::DecoratorsConcern

  def state_color(item)
    if item.methods.include? :unviewed?
      :success if item.unviewed?
    end
  end

  def tab_title(model_class, tab, count, state_method = :state)
    model = model_class.name.underscore
    model = :team if model.include? 'team'
    "#{t("activerecord.state_machines.#{model}.#{state_method}.states.#{tab}").pluralize(:ru)} / #{count}"
  end

  def search_tab_title(count)
    "#{t("helpers.found")} / #{count}"
  end

  def searchable_model?(model_class)
    model_class.methods.include? :search_everywhere
  end

  def form_after_save?
    referrer = Rails.application.routes.recognize_path request.referrer
    referrer[:controller] == params[:controller] && referrer[:action] == params[:action]
  end

  def object_updated_less_minute_ago?(object)
    if object.model.updated_at
      ((DateTime.now - object.model.updated_at.to_datetime) * 24 * 60).to_i < 1
    end
  end

  def model_class
    request[:controller].split('/')[2..-1].join('/').singularize.camelize.constantize
  end

  def to_path(constant)
    constant = Team if constant.to_s.include? 'Team'
    constant.name.underscore.gsub '/', '_'
  end

  include Concerns::Trash

  def beta_testing_notice
    content_tag :div, class: 'alert alert-dissmissible alert-info' do
      content_tag :span, t('notices.functional_in_beta'), class: 'glyphicon glyphicon-info-sign'
    end
  end

  def hint(model_name, attribute_name)
    content_tag :div, class: 'alert alert-dissmissible alert-info' do
      content_tag :span, t("hints.admin.#{model_name.to_s.underscore}.#{attribute_name}"), class: 'glyphicon glyphicon-info-sign'
    end
  end

  def searching?
    params[:search].present?
  end

  def get_collection(model_class)
    "#{model_class}Decorator".constantize.collections
  end

  def admin_index_path_of_model(model_class, tab)
    send("admin_#{to_path(model_class).pluralize(:en)}#{model_class == News ? '_index' : ''}_path", scope: tab)
  end

  def admin_record_path(instance)
    send("admin_#{instance.record_type.underscore}_path", instance.record_id)
  end

  def record_title(instance)
    [t("activerecord.models.#{instance.record_type.underscore}"), decorator_class(instance.record_type).decorate(instance.record).name].join ': '
  end
end
