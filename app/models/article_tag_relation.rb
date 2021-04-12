class ArticleTagRelation < ApplicationRecord
  include ActiveModel::Model
  attr_accessor :title, :ingredients, :text, :trick, :name

  with_options presence: true do
    validates :title
    validates :text
    validates :ingredients
    validates :trick
    validates :name
  end

  def save
    article = Article.create(title: title, ingredients: ingredients, text: text, trick: trick, youtube_url: youtube_url)
    tag = Tag.create(name: name)

    ArticleTagRelation.create(article_id: article.id, tag_id: tag.id)
  end
end