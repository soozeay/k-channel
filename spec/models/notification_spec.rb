require 'rails_helper'

RSpec.describe Notification, type: :model do
  before do
    # visitorがvisitedさんにactionを起こすとnotificationが生成される(visited_id == article_id)
    @visitor = FactoryBot.create(:user)
    @visited = FactoryBot.create(:user)
    @article = FactoryBot.create(:article)
    @notification = FactoryBot.build(:notification, visitor_id: @visitor.id, visited_id: @visited.id, article_id: @article.id,
                                                    action: 'like')
    sleep(0.1)
  end

  describe '通知機能' do
    context '通知レコードが生成できるとき' do
      it '情報が全て揃っている状態でいいねされたときに通知できる' do
        expect(@notification).to be_valid
      end
      it '情報が全て揃っている状態で@visitorのユーザーをフォローしたときに通知できる' do
        @notification.action = 'follow'
        expect(@notification).to be_valid
      end
      it '情報が全て揃っている状態で@visitedのユーザーをフォローしたときに通知できる' do
        @notification.visitor_id = @visited.id
        @notification.visited_id = @visitor.id
        @notification.action = 'follow'
        expect(@notification).to be_valid
      end
      it '情報が全て揃っている状態でコメントすると通知できる' do
        @article.user_id = @visited.id
        @comment = FactoryBot.create(:comment, user_id: @visitor.id, article_id: @article.id)
        @notification.action = 'comment'
        expect(@notification).to be_valid
      end
    end

    context '通知できないとき' do
      it 'visitor_idが空ではいいねできたとしても通知できない' do
        @notification.visitor_id = ''
        @notification.valid?
        expect(@notification.errors.full_messages).to include('Visitorを入力してください')
      end
      it 'visited_idが空ではいいねできたとしても通知できない' do
        @notification.visited_id = ''
        @notification.valid?
        expect(@notification.errors.full_messages).to include('Visitedを入力してください')
      end
      it 'visitor_idが空ではフォローできたとしても通知できない' do
        @notification.visitor_id = ''
        @notification.action = 'follow'
        @notification.valid?
        expect(@notification.errors.full_messages).to include('Visitorを入力してください')
      end
      it 'visited_idが空ではフォローできたとしても通知できない' do
        @notification.visited_id = ''
        @notification.action = 'follow'
        @notification.valid?
        expect(@notification.errors.full_messages).to include('Visitedを入力してください')
      end
    end
  end
end
