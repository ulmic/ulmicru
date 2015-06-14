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
end
