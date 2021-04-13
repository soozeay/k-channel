class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  with_options presence: true do
    validates :user_id
    validates :follow_id
  end
end
