module UsersHelper

  def follow_users
    # フォローユーザーを配列で取得
    @follow_users = Relationship.where(user_id: current_user)

  end
    
  # @follower_users = current_user.followers
end
