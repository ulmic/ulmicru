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
     object.published_at.strftime('%d %b %Y %H:%m')
  end

  def name 
    "#{model.title.first(30)}"
  end

end
