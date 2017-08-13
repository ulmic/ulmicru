module Web::ProjectsHelper
  def form_attribute_locale(form, attribute)
    I18n.t("activerecord.attributes.forms.#{form.name.underscore}.#{attribute}")
  end
end
