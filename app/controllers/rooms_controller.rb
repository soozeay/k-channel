class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rooms, only: [:index, :show]

  def index
  end

  def create
    @room = Room.create
    @entry_current_user = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry_follower = Entry.create(room_params)
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.includes(:user)
      @message = Message.new
      @entries = @room.entries
      entry = @room.entries.where.not(user_id: current_user)
      @user = entry[0].user
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def room_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end

  def set_rooms
    @rooms = current_user.rooms.joins(:messages).includes(:messages).order("messages.created_at DESC")
  end
end