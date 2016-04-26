class LetterDecorator < ApplicationDecorator
  delegate_all

  def name
    object.title
  end

  def year
    I18n.l object.send_date.to_datetime, format: '-%y' if object.send_date
  end

  def formatted_send_date
    I18n.l object.send_date.to_datetime, format: '%d.%m.%Y' if object.send_date
  end

  def present_executor
    executor ? executor.decorate.short_name : executor_name
  end

  def self.collections
    [ :sended, :unviewed ]
  end
end
