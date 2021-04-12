class Tag < ApplicationRecord
  has_many :article_tag_relations
  has_many :articless, through: :article_tag_relations
end
