require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @follower_user = FactoryBot.create(:user)
    @relationship = Relationship.new(user_id: @user.id, follow_id: @follower_user.id)
    sleep(0.3)
  end
  describe 'フォロー機能' do
    context 'フォローできるとき' do
      it 'user_idとfollow_idがあればフォローできる' do
        expect(@relationship).to be_valid
      end
    end
    context 'フォローできないとき' do
      it 'user_idが空ではフォローできない' do
        @relationship.user_id = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include('Userを入力してください')
      end
      it 'follow_idが空ではフォローできない' do
        @relationship.follow_id = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include('Followを入力してください')
      end
      it '重複するフォローはできない' do
        @relationship.save
        @another_relationship = Relationship.new(user_id: @user.id, follow_id: @follower_user.id)
        @another_relationship.valid?
        expect(@another_relationship.errors.full_messages).to include('Userはすでに存在します')
      end
    end
  end
end
