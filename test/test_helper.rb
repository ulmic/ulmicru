if ENV["TRAVIS"]
  require 'coveralls'
  Coveralls.wear!
end

require 'simplecov'
ENV["RAILS_ENV"] = "test"
SimpleCov.start('rails') if ENV["COVERAGE"]

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'

FactoryGirl.reload

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include Concerns::AuthManagment

  def load_fixture(filename)
    template = ERB.new(File.read(File.dirname(__FILE__) + "/fixtures/#{filename}"), nil, "%")
    template.result
  end

  Category.create name: 'Контакты'
  Category.first.articles.build(title: 'Контакты', user_id: 1).save

  month_article_id = 21
  a = Article.find month_article_id
  unless a
    a = Article.create title: 'Статья месяца'
    a.id = month_article_id
    a.save
  end
end
