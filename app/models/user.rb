class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :password, :password_confirmation, format: { with: /\A(?=.*?[a-z])(?=.*?[\d)])[a-z\d]+\z/i }
  validates :age, numericality: { greater_than_or_equal_to: 20, less_than_or_equal_to: 120 }
  validates :intro, length: { maximum: 200 }

  has_one_attached :avater
  has_one_attached :cover

  extend ActiveHash::Associations::ActiveRecordExtensions
  with_options presence: true, numericality: { other_than: 0 } do
    validates :gender_id
    validates :country_id
  end

  has_many :articles
  belongs_to :gender
  belongs_to :country
end
