class Api::NewsController < Api::ApplicationController
  before_filter :allow_get_news

  # FIXME remove hash creating from controller
  def index
    source = get_source
    news = NewsDecorator.decorate source.published.drop params[:offset].to_i
    news = news.first params[:count].to_i if params[:count]
    hash = []
    if params[:data] == 'id'
      hash = news.map &:id
    else
      news.each { |n| n = n.decorate; hash << { id: n.id, title: n.title, text: n.short_lead, publish_date_time: n.publish_date_time, photo: n.photo.url }  }
    end
    render json: hash
  end

  private

  def get_source
    if params[:tag].present?
      tags = []
      if params[:tag][:tag_type] == 'link'
        tags = params[:tag][:target_type].constantize.find_by_title(params[:tag][:title]).tags
      else
        tags = Tag.where text: params[:tag][:text], tag_type: 'string'
      end
      News.where id: tags.where(record_type: 'News').map(&:record).map(&:id)
    else
      News
    end
  end

  private

  def allow_get_news
    headers['Access-Control-Allow-Origin'] = 'http://ul-lider.ru'
  end
end
