class NewsController < ApplicationController

  def index
    require 'news-api'
    news = News.new(ENV['NEWS_API_KEY'])
    if I18n.locale.to_s == "ja"
      @news = news.get_top_headlines(country: 'jp')
    else
      @news = news.get_top_headlines(country: 'kr')
    end
    if params[:category].present?
      @news = news.get_top_headlines(country: params[:country], category: params[:category])
    end
  end

end
