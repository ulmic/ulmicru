module Web::Admin::UnviewedHelper
  def unviewed_tab_title(model_name, count)
    "#{t("activerecord.models.#{model_name}").pluralize(:ru)} / #{count}"
  end

  # FIXME refactor
  def no_any_unviewed?(unviewed)
    unviewed.keys.each do |key|
      return false if unviewed[key.to_s.pluralize(:en).to_sym].total_count
    end
  end
end
