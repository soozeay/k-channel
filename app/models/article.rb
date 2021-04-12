class Article < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :text
    validates :ingredients
    validates :trick
  end
  belongs_to :user
  has_many :comments
  has_one_attached :image
  has_rich_text :text
  has_many :article_tag_relations
  has_many :tags, through: :article_tag_relations

  def self.search(search)
    if search != ""
      Article.where(['title LIKE(?) OR ingredients LIKE(?) OR trick LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Article.all
    end
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :plaza_id, presence: true, numericality: { other_than: 0 }
  belongs_to :plaza
end