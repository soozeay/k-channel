module UsersHelper
  def follow_users
    # フォローユーザーを配列で取得
    @follow_users = @user.followings
  end

  def follower_users
    @follower_users = @user.followers
  end

  def like_articles
    @like_articles = @user.likes
  end
end
