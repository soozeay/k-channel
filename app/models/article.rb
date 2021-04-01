class Article < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :text
    validates :ingredients
    validates :trick
    validates :image
  end
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :plaza_id, presence: true, numericality: { other_than: 0 }
  belongs_to :plaza
end