require 'russian_cases'

module LocalsHelper
  include RussianCases

  def page_title(action, model_name)
    t("helpers.actions.#{action}") + ' ' + genitive(model_name)
  end

  def trash_page_title(model_class)
    t('web.admin.trash.deleted') + ' ' + model_class.model_name.human.pluralize(:ru).mb_chars.downcase.to_s
  end

end
