# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:ru) do |inflect|
  inflect.plural /ль$/i, 'ли'
  inflect.plural /н /i, 'ны '
  inflect.plural /та /i, 'ты '
  inflect.plural /ие /i, 'ия '
  inflect.plural /ть$/i, 'ти'
  inflect.plural /ое$/i, 'ые'
  inflect.plural /ый$/i, 'ые'
  inflect.plural /ая$/i, 'ые'
  inflect.plural /тья$/i, 'тьи'
  inflect.plural /ия$/i, 'ии'
  inflect.plural /ие$/i, 'ия'
  inflect.plural /ер$/i, 'еры'
  inflect.plural /да$/i, 'ды'
  inflect.plural /нт$/i, 'нты'
  inflect.plural /ий$/i, 'ие'
  inflect.plural /ментарий$/i, 'ментарии'
  inflect.plural /мо$/i, 'ма'
  inflect.plural /лог действия$/i, 'Логи действий'
end
