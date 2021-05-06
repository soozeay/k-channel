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

RSpec.describe "Likes", type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
  end

  context 'いいねできるとき' do
    it 'ログインユーザーが他人の投稿にいいねできる' do
      # ログインし、root_pathにいることを確認する
      sign_in(@article1.user)
      # @article2の詳細ページに遷移する
      visit article_path(@article2)
      expect(page).to have_content(@article2.title)
      # いいねボタンがあることを確認する
      expect(page).to have_selector(".thumbs-up-btn")
      # いいねボタンをクリックすると、Likeモデルのカウントが1上がることを確認する
      expect{find('.thumbs-up-btn').click}.to change { Like.count }.by(1)
    end
  end
  context 'いいねできないとき' do
    it '自分の投稿にはいいねできない' do
      # ログインし、root_pathにいることを確認する
      sign_in(@article1.user)
      # 自分の投稿（@article1）の詳細ページに遷移する
      visit article_path(@article1)
      expect(page).to have_content(@article1.title)
      # いいねボタンがあることを確認する
      expect(page).to have_no_selector(".thumbs-up-btn")
    end
    it 'ログインしていないユーザーはいいねできない' do
      basic_pass root_path
      visit root_path
      # @article2の詳細ページに遷移するも失敗している事を確認する
      visit article_path(@article2)
      expect(current_path).to eq(user_session_path)
    end
  end
  context 'いいねの連打による異常なカウントがされないか確認する' do
    it '他人の投稿のいいねボタンを連打してもカウントは1つしか上がらない' do
      # ログインし、root_pathにいることを確認する
      sign_in(@article1.user)
      # @article2の詳細ページに遷移する
      visit article_path(@article2)
      expect(page).to have_content(@article2.title)
      # いいねボタンがあることを確認する
      expect(page).to have_selector(".thumbs-up-btn")
      # いいねボタンをクリックすると、Likeモデルのカウントが1上がることを確認する
      expect{find('.thumbs-up-btn').click}.to change { Like.count }.by(1)
      # もう一度いいねボタンをクリックして、いいねを解除するとカウントが一つ減る
      expect{find('.thumbs-up-btn').click}.to change { Like.count }.by(-1)
      # もう一度いいねボタンをクリックして、いいねをするとカウントが一つ増える
      expect{find('.thumbs-up-btn').click}.to change { Like.count }.by(1)
    end
  end
end
