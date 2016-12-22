class LoggedActionDecorator < ApplicationDecorator
  delegate_all

  def name
    "#{object.user.decorate.short_name} #{object.record.decorate.name}" if object
  end

  def user_short_name
    object.user.decorate.short_name
  end

  def updated_params
    if object.action_type == 'update'
      object.parsed_params.map do |param|
        "#{'Изменено:' if param[0] == '~'} #{t("activerecord.attributes.#{object.record_type.underscore}.#{param[1]}")} c '#{param[2]}' на '#{param[3]}'"
      end
    end
  end
end
