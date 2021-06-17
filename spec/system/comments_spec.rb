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

RSpec.describe 'Comments', type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
    @comment = Faker::Lorem.sentence
  end

  context 'コメントできるとき' do
    it 'ログインしたユーザーはコメントできる（自分の投稿にコメントする場合）' do
      # ログインし、root_pathにいることを確認する
      sign_in(@article1.user)
      expect(current_path).to eq root_path
      expect(page).to have_no_content('ログイン')
      # @article1の詳細ページに遷移する
      visit article_path(@article1)
      expect(page).to have_content(@article1.title)
      # コメント欄があることを確認、フォームに入力する
      expect(page).to have_selector('.send-comment-text')
      fill_in 'コメントを入力', with: @comment
      # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
      expect { find('input[name="commit"]').click }.to change { Comment.count }.by(1)
      # コメントがページこのページ内に存在しているか確認する
      expect(page).to have_content(@comment)
    end
    it 'ログインしたユーザーはコメントできる（他人の投稿（@article2）にコメントする場合）' do
      # ログインし、root_pathにいることを確認する
      sign_in(@article1.user)
      expect(current_path).to eq root_path
      expect(page).to have_no_content('ログイン')
      # @article1の詳細ページに遷移する
      visit article_path(@article2)
      expect(page).to have_content(@article2.title)
      # コメント欄があることを確認、フォームに入力する
      expect(page).to have_selector('.send-comment-text')
      fill_in 'コメントを入力', with: @comment
      # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
      expect { find('input[name="commit"]').click }.to change { Comment.count }.by(1)
      # コメントがページこのページ内に存在しているか確認する
      expect(page).to have_content(@comment)
    end
  end
  context 'コメントできないとき' do
    it 'ログインしていないユーザーはコメントできない' do
      # トップページに遷移する
      basic_pass root_path
      visit root_path
      # @article1の詳細ページに遷移するも失敗している事を確認する
      visit article_path(@article1)
      expect(current_path).to eq(user_session_path)
      visit article_path(@article2)
      expect(current_path).to eq(user_session_path)
    end
    it '空欄のコメント送信はできない' do
      # ログインし、root_pathにいることを確認する
      sign_in(@article1.user)
      expect(current_path).to eq root_path
      expect(page).to have_no_content('ログイン')
      # @article1の詳細ページに遷移する
      visit article_path(@article1)
      expect(page).to have_content(@article1.title)
      # コメント欄があることを確認、フォームに入力する
      expect(page).to have_selector('.send-comment-text')
      fill_in 'コメントを入力', with: ''
      # コメントを送信しても、Commentモデルのカウントが上がらない事を確認する
      expect { find('input[name="commit"]').click }.to change { Comment.count }.by(0)
      # コメントがページこのページ内に存在していないか確認する
      expect(page).to have_no_content(@comment)
    end
  end
end
