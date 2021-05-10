class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      @user.create_notification_follow!(current_user)
      redirect_to @user, notice: 'フォローに成功しました'
    else
      redirect_to @user
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      redirect_to @user, notice: 'フォローを解除しました'
    else
      redirect_to @user, alert: 'フォローを解除しました'
    end
  end

  private
  def set_user
    @user = User.find(params[:follow_id])
  end
end
