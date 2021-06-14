class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      @user.create_notification_follow!(current_user)
      if I18n.locale.to_s == "ja"
        redirect_to @user, notice: 'フォローに成功しました'
      else
        redirect_to @user, notice: '팔로우 했습니다'
      end
    else
      redirect_to @user
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      if I18n.locale.to_s == "ja"
        redirect_to @user, notice: 'フォローを解除しました'
      else
        redirect_to @user, notice: '팔로우를 해제했습니다'
      end
    else
      redirect_to @user
    end
  end

  private
  def set_user
    @user = User.find(params[:follow_id])
  end
end
