require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

def sign_in(user)
  basic_pass root_path
  visit root_path
  visit new_user_session_path
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password
  find('input[name="commit"]').click
  expect(current_path).to eq root_path
  expect(page).to have_no_content('ログイン')
end

def another_user_sign_in(user)
  # マイページに戻る
  expect(page).to have_selector(".user-nickname")
  find('.user-nickname').click
  # サインアウトする
  expect(page).to have_selector(".sign-out")
  find('.sign-out').click
  expect(current_path).to eq root_path
  # 別のユーザーでログインする
  visit new_user_session_path
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password
  find('input[name="commit"]').click
  expect(current_path).to eq root_path
  expect(page).to have_no_content('ログイン')
end

RSpec.describe "通知機能", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @article1 = FactoryBot.create(:article, user_id: @user1.id)
    @article2 = FactoryBot.create(:article, user_id: @user2.id)
    @comment = FactoryBot.create(:comment, user_id: @user1.id)
    sleep(0.1)
  end

  context '正しく通知できる' do
    it '@user2をフォローすると、@user2に通知が届く' do
      # @user1でログインする
      sign_in(@user1)
      expect(current_path).to eq root_path
      # @user2の詳細ページへ遷移する
      visit user_path(@user2)
      expect(current_path).to eq user_path(@user2.id)
      # フォローのボタンが画面にあることを確認する
      expect(page).to have_selector(".follow-btn")
      # フォローボタンをクリックするとRelationshipモデルのカウントが1上がることを確認する
      expect{find('.follow-btn').click}.to change { Relationship.count }.by(1)
      # もう一人のユーザーでログインしなおす
      another_user_sign_in(@user2)
      # トップページの通知アイコンをクリックして通知ページへ遷移する
      expect(page).to have_selector('.notification-icon')
      find('.notification-icon').click
      expect(current_path).to eq notifications_path
      # フォローされた通知があることを確認する
      expect(page).to have_content("#{@user1.nickname} さんが あなたをフォローしました")
    end
    it '記事にコメントをすると通知が届く' do
      # @user1でログインする
      sign_in(@user1)
      expect(current_path).to eq root_path
      # @article2の詳細ページへ遷移する
      visit article_path(@article2)
      expect(page).to have_content(@article2.title)
      # コメント欄を特定しする
      expect(page).to have_selector(".send-comment-text")
      fill_in "コメントを入力", with: @comment
      # コメントを送信し、画面にそのコメントが存在することを確認する
      find('input[name="commit"]').click
      expect(page).to have_content(@comment)
      # もう一人のユーザーでログインしなおす
      another_user_sign_in(@user2)
      # トップページの通知アイコンをクリックして通知ページへ遷移する
      expect(page).to have_selector('.notification-icon')
      find('.notification-icon').click
      expect(current_path).to eq notifications_path
      # フォローされた通知があることを確認する
      expect(page).to have_content("#{@user1.nickname} さんが あなたの投稿 にコメントしました")
    end
    it '記事にいいねされると通知が届く' do
      # @user1でログインする
      sign_in(@user1)
      expect(current_path).to eq root_path
      # @article2の詳細ページへ遷移する
      visit article_path(@article2)
      expect(page).to have_content(@article2.title)
      # いいねボタンがあることを確認する
      expect(page).to have_selector(".thumbs-up-btn")
      # いいねボタンをクリックする
      find(".thumbs-up-btn").click
      # もう一人のユーザーでログインしなおす
      another_user_sign_in(@user2)
      # トップページの通知アイコンをクリックして通知ページへ遷移する
      expect(page).to have_selector('.notification-icon')
      find('.notification-icon').click
      expect(current_path).to eq notifications_path
      # フォローされた通知があることを確認する
      expect(page).to have_content("#{@user1.nickname} さんが あなたの投稿 にいいねしました")
    end
  end
  context '通知できないとき' do
    it '空のコメントを送信しても通知は行かない' do
      # @user1でログインする
      sign_in(@user1)
      expect(current_path).to eq root_path
      # @article2の詳細ページへ遷移する
      visit article_path(@article2)
      expect(page).to have_content(@article2.title)
      # コメント欄を特定しする
      expect(page).to have_selector(".send-comment-text")
      fill_in "コメントを入力", with: ''
      # コメントを送信し、画面にそのコメントが存在することを確認する
      find('input[name="commit"]').click
      expect(page).to have_no_content(@comment)
      # もう一人のユーザーでログインしなおす
      another_user_sign_in(@user2)
      # トップページの通知アイコンをクリックして通知ページへ遷移する
      expect(page).to have_selector('.notification-icon')
      find('.notification-icon').click
      expect(current_path).to eq notifications_path
      # フォローされた通知があることを確認する
      expect(page).to have_no_content("#{@user1.nickname} さんが あなたの投稿 にコメントしました")
    end
  end
end