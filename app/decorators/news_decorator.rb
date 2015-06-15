class NewsDecorator < ApplicationDecorator
  delegate_all

  def generate_lead
    @sentences = ActionController::Base.helpers.strip_tags(model.body).split('.')
    @finally_sen = "#{@sentences[0]}."
    (1..2).each { |i| @finally_sen += "#{@sentences[i]}." }
    @finally_sen
  end

  def description_lead
    "#{model.body.first(200)}..."
  end

  def long_lead
    "#{model.body.first(600)}..."
  end

  def publish_date
    I18n.l published_at, format: '%d %b %Y'
  end

  def publish_date_time
    I18n.l published_at, format: "%d %b %Y #{I18n.t('helpers.year')} %H:%m"
  end

  def name
    model.title.first 30
  end

  def short_lead
    "#{model.lead.first(100)}..."
  end

  def author_name
    member.present? ? member.decorate.short_name : I18n.t('helpers.no_author')
  end

end
