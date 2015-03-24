class NewsDecorator < Draper::Decorator
  delegate_all

  def short_lead
    "#{model.body.first(50)}..."
  end

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

  def publish_date_time
    I18n.l published_at, format: '%d %b %Y'
  end

  def name
    model.title.first 30
  end

  def short_lead
    "#{model.lead.first(140)}..."
  end

  def author_name
    user.present? ? user.decorate.short_name : I18n.t('helpers.no_author')
  end

end
