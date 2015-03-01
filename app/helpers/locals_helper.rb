require 'russian_cases'

module LocalsHelper
  include RussianCases

  def page_title(action, model_name)
    t("helpers.actions.#{action}") + ' ' + genitive(model_name)
  end
end
