class Article < ApplicationRecord
  
  belongs_to :user
  has_many :comments
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_one_attached :image
  has_rich_text :text
  acts_as_taggable

  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :plaza_id, presence: true, numericality: { other_than: 0 }
  belongs_to :plaza
end