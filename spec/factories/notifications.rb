FactoryBot.define do
  factory :notification do
    visitor_id { @visitor.id }
    visited_id { @visited.id }
    article_id { @article.id }
    action { 'like' }

    association :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
    association :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
    association :article, uniqueness: true, scope: :user_id
    association :comment
  end
end
