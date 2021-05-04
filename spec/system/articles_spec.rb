require 'rails_helper'

RSpec.describe "Articles", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.build(:article)
  end

  def basic_pass(path)
    username = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  context '投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      basic_pass root_path
      visit root_path
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      fill_in 'item-name', with: @article.title
      select 'コスメ', from: 'item-category'
      # 送信するとArticleモデルのカウントが1上がることを確認する
      expect{find('button[name="button"]').click}.to change { Article.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿した内容の@articleが存在することを確認する
      expect(page).to have_content(@article.title)
    end
    it '正しいYoutubeのURLを記載すれば投稿できる' do
      # ログインする
      basic_pass root_path
      visit root_path
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      fill_in 'item-name', with: @article.title
      fill_in 'article_youtube_url', with: @article.youtube_url
      select 'コスメ', from: 'item-category'
      # 送信するとArticleモデルのカウントが1上がることを確認する
      expect{find('button[name="button"]').click}.to change { Article.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿した内容の@articleが存在することを確認する
      expect(page).to have_content(@article.title)
    end
  end
  context '投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      basic_pass root_path
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')
    end
    it 'タイトルが空欄では投稿できない' do
      # ログインする
      basic_pass root_path
      visit root_path
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      fill_in 'item-name', with: ''
      select 'コスメ', from: 'item-category'
      # 送信してもArticleモデルのカウントが上がらないことを確認する
      expect{find('button[name="button"]').click}.to change { Article.count }.by(0)
      # 新規投稿ページに遷移することを確認する
      expect(current_path).to eq articles_path
    end
    it 'カテゴリーが空欄では投稿できない' do
      # ログインする
      basic_pass root_path
      visit root_path
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      fill_in 'item-name', with: @article.title
      # 送信してもArticleモデルのカウントが上がらないことを確認する
      expect{find('button[name="button"]').click}.to change { Article.count }.by(0)
      # 新規投稿ページに遷移することを確認する
      expect(current_path).to eq articles_path
    end
    it 'youtube_urlが不正な値では投稿できない' do
      # ログインする
      basic_pass root_path
      visit root_path
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      fill_in 'item-name', with: @article.title
      fill_in 'article_youtube_url', with: Faker::Internet.url
      select 'コスメ', from: 'item-category'
      # 送信してもArticleモデルのカウントが上がらないことを確認する
      expect{find('button[name="button"]').click}.to change { Article.count }.by(0)
      # 新規投稿ページに遷移することを確認する
      expect(current_path).to eq articles_path
    end
  end
end