class MessagesController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
      @room = @message.room
      redirect_to  room_path(@message.room_id)
      ActionCable.server.broadcast 'room_channel', message: @message, room_id: @room.id, user_image: current_user.avatar
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to room_path(@message.room.id), notice: 'メッセージを取り消しました'
  end
  
end
