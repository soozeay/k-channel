class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_user, only: [:show, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]


  def show
    @articles = @user.articles.order('created_at DESC')
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
        unless @isRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def update_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :cover, :avater, :intro)
  end

  def move_to_index
    redirect_to root_path if @user.id != current_user.id
  end
end
