class Article < ApplicationRecord
  belongs_to :user

  # 記事の投稿について
  validates :title, presence: true, length: { maximum: 40 }
  validates :trick, length: { maximum: 1000 }
  has_one_attached :image
  validates :youtube_url, format: { with: %r{\A(https://)?(www\.)?(youtube\.com/watch\?v=|youtu\.be/)+\S{11}\z} },
                          allow_blank: true
  has_rich_text :text
  acts_as_taggable
  validate :tag_list_tag_validation

  # コメント機能
  has_many :comments, dependent: :destroy

  # いいね機能
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # 通知機能
  has_many :notifications, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :plaza_id, presence: true, numericality: { other_than: 0 }
  belongs_to :plaza

  # タグは5つまでに制限
  def tag_list_tag_validation
    tag_validation = tag_list
    tag_validation.split(',')
    errors.add(:tag_list, 'は５個までです') if tag_validation.length > 5
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(['visitor_id = ? and visited_id = ? and article_id = ? and action = ? ', current_user.id, user_id,
                               id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        article_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(article_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      article_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

  scope :by_any_texts, lambda { |string|
    words = string.split(/[\p{blank}\s]+/)
    searchs = search(title_or_user_nickname_cont_all: words).result(distinct: true)
    search_tag = Article.by_any_tag(words)
    search_result = (searchs + search_tag).uniq
  }

  scope :by_any_tag, lambda { |words|
    article_tag = Article.tagged_with(words, named_like_any: true)
  }

  def self.ransackable_scopes(_auth_object = nil)
    %i[text_or_user_name_cont_all]
  end
end
