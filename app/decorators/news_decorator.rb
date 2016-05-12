class NewsDecorator < ApplicationDecorator
  delegate_all

  decorates_association :member

  def generate_lead
    @sentences = strip_tags(model.body).split('.')
    @finally_sen = "#{@sentences[0]}."
    (1..2).each { |i| @finally_sen += "#{@sentences[i]}." }
    @finally_sen
  end

  def description_lead
    "#{model.body.first(200)}..."
  end

  def full_text
    "#{model.lead}\n#{model.body}"
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

  def short_lead
    "#{model.lead.first(100)}..."
  end

  alias name :short_lead

  def author_name
    member.present? ? member.decorate.short_name : I18n.t('helpers.no_author')
  end


  def self.collections
    [:published, :unpublished, :unviewed, :main]
  end
end
