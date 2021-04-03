class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_user, only: [:show, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]


  def show
    @articles = @user.articles
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :cover, :avater, :intro)
  end

  def move_to_index
    redirect_to root_path if @user.id != current_user.id
  end
end
