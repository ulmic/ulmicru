module Web::Admin::UnviewedHelper
  def unviewed_tab_title(model_name, count)
    "#{t("activerecord.models.#{model_name}").pluralize(:ru)} / #{count}"
  end
end
