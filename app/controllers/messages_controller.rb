class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :correct]
  before_action :set_message, only: [:destroy, :correct]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
      @room = @message.room
      redirect_to  room_path(@message.room_id)
      ActionCable.server.broadcast 'room_channel', message: @message, room_id: @room.id, user_image: current_user.avatar
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message.destroy
    redirect_to room_path(@message.room.id), notice: 'メッセージを取り消しました'
  end

  def correction
    @target_msg = Message.find(params[:id])
    @room = @target_msg.room
  end

  def correct
    @target_msg = Message.find(params[:id])
    @room = @target_msg.room
    @message = Message.new(params.permit(:user_id, :message, :target_message, :room_id).merge(user_id: current_user.id))
    if @message.valid?
      @message.save
      redirect_to room_path(@message.room.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  end
  
end
