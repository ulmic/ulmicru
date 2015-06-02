class Api::NewsController < Api::ApplicationController
  def index
    news = NewsDecorator.decorate News.published.drop(params[:offset].to_i).first(params[:count].to_i)
    hash = []
    news.each { |n| n = n.decorate; hash << { id: n.id, title: n.title, text: n.short_lead, publish_date_time: n.publish_date_time  }  }
    render json: hash
  end
end
