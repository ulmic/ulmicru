# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:ru) do |inflect|
  inflect.plural /ль$/i, 'ли'
  inflect.plural /н /i, 'ны '
  inflect.plural /та /i, 'ты '
  inflect.plural /ть$/i, 'ти'
end
