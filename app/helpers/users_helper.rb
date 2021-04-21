module UsersHelper

  def follow_users
    # フォローユーザーを配列で取得
    @follow_users = current_user.followings
  end
    
  def follower_users
    @follower_users = current_user.followers
  end

  def like_articles
    @like_articles = current_user.likes
  end
end
