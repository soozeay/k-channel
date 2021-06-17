require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージの投稿機能' do
    context '投稿できるとき' do
      it 'フォームに入力していれば投稿できる' do
        expect(@message).to be_valid
      end
    end

    context '投稿できないとき' do
      it 'メッセージが空では投稿できない' do
        @message.message = ''
        @message.valid?
        expect(@message.errors.full_messages).to include('メッセージを入力してください')
      end
      it 'ユーザー情報が空では投稿できない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('Userを入力してください')
      end
      it 'Room情報が空では投稿できない' do
        @message.room = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('Roomを入力してください')
      end
    end
  end
end
