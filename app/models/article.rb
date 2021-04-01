class Article < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :text
    validates :ingredients
    validates :trick
  end
  belongs_to :user
  belongs_to :plaza
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :plaza_id, presence: true, numericality: { other_than: 0 }
  
end