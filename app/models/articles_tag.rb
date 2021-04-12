class ArticlesTag

  include ActiveModel::Model
  attr_accessor :title, :ingredients, :text, :trick, :plaza_id, :name, :image, :youtube_url, :user_id

  with_options presence: true do
    validates :title
    validates :text
    validates :ingredients
    validates :trick
    validates :name
  end

  def save
    article = Article.create( title: title, ingredients: ingredients, trick: trick, youtube_url: youtube_url, plaza_id: plaza_id, user_id: user_id)
    binding.pry
    tag = Tag.create(name: name)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    ArticleTagRelation.create(article_id: article.id, tag_id: tag.id)
  end
end