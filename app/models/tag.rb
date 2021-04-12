class Tag < ApplicationRecord
  has_many :article_tag_relations, dependent: :destroy
  has_many :articless, through: :article_tag_relations

  validates :name, uniqueness: true
end
