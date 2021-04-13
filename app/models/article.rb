class Article < ApplicationRecord
  
  belongs_to :user
  has_many :comments
  has_one_attached :image
  has_rich_text :text
  acts_as_taggable

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