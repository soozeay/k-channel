class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :correct]
  before_action :set_message, only: [:destroy, :correct]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
      @room = @message.room
      ActionCable.server.broadcast 'room_channel', message: @message, room_id: @room.id, user_image: current_user.avatar,
                                                   user_id: @message.user_id, nickname: @message.user.nickname
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message.destroy
    if I18n.locale.to_s == 'ja'
      redirect_to room_path(@message.room.id), notice: 'メッセージを取り消しました'
    else
      redirect_to room_path(@message.room.id), notice: '메시지를 취소했습니다'
    end
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
      ActionCable.server.broadcast 'room_channel', target_message: @target_msg, message: @message, room_id: @room.id, user_image: current_user.avatar,
                                                   user_id: @message.user_id, nickname: @message.user.nickname
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
