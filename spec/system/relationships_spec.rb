require 'rails_helper'

def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

def sign_in(user)
  basic_pass root_path
  visit root_path
  visit new_user_session_path
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password
  find('input[name="commit"]').click
end

RSpec.describe 'Relationships', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)
  end

  context 'ユーザーフォロー機能を問題なく使用できる場合' do
    it '他人の詳細ページに入ってフォローボタンを押すとフォローできる' do
      # ログインし、root_pathにいることを確認する
      sign_in(@user)
      # @another_userのページに遷移する
      visit user_path(@another_user)
      # フォローのボタンが画面にあることを確認する
      expect(page).to have_selector('.follow-btn')
      # フォローボタンをクリックするとRelationshipモデルのカウントが1上がることを確認する
      expect { find('.follow-btn').click }.to change { Relationship.count }.by(1)
    end
    it '上記で一度フォローしたユーザーは、同ページで同じボタンをクリックするとフォローを外せる' do
      # ログインし、root_pathにいることを確認する
      sign_in(@user)
      # @another_userのページに遷移する
      visit user_path(@another_user)
      # フォローのボタンが画面にあることを確認する
      expect(page).to have_selector('.follow-btn')
      # フォローボタンをクリックするとRelationshipモデルのカウントが1上がることを確認する
      expect { find('.follow-btn').click }.to change { Relationship.count }.by(1)
      # 再度フォローボタンをクリックするとフォロー解除となり、モデルのカウントが１つ減る
      expect { find('.follow-btn').click }.to change { Relationship.count }.by(-1)
    end
  end
  context 'フォローできない場合' do
    it '自分はフォローできない' do
      # ログインし、root_pathにいることを確認する
      sign_in(@user)
      # @userのページに遷移する
      visit user_path(@user)
      # フォローのボタンが画面にないことを確認する
      expect(page).to have_no_selector('.follow-btn')
    end
    it 'ログインしていないとフォローできない' do
      basic_pass root_path
      visit root_path
      # @article2の詳細ページに遷移するも失敗している事を確認する
      visit article_path(@another_user)
      expect(current_path).to eq(user_session_path)
    end
  end
end
