class Article < ApplicationRecord
  
  belongs_to :user
  has_many :comments
  has_one_attached :image
  has_rich_text :text
  has_many :article_tag_relations, dependent: :destroy
  has_many :tags, through: :article_tag_relations

  def self.search(search)
    if search != ""
      Article.where(['title LIKE(?) OR ingredients LIKE(?) OR trick LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Article.all
    end
  end

  def save_tags(article_tags)
    article_tags.each do |new_name|
    article_tag = Tag.find_or_create_by(name: new_name)
    self.tags << article_tag
    end
  end


  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :plaza_id, presence: true, numericality: { other_than: 0 }
  belongs_to :plaza
end