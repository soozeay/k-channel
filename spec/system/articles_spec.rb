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

RSpec.describe '投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.build(:article)
  end

  context '投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      fill_in 'item-name', with: @article.title
      select 'コスメ', from: 'item-category'
      # 送信するとArticleモデルのカウントが1上がることを確認する
      expect { find('button[name="button"]').click }.to change { Article.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿した内容の@articleが存在することを確認する
      expect(page).to have_content(@article.title)
    end
    it '正しいYoutubeのURLを記載すれば投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      fill_in 'item-name', with: @article.title
      fill_in 'article_youtube_url', with: @article.youtube_url
      select 'コスメ', from: 'item-category'
      # 送信するとArticleモデルのカウントが1上がることを確認する
      expect { find('button[name="button"]').click }.to change { Article.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿した内容の@articleが存在することを確認する
      expect(page).to have_content(@article.title)
    end
  end
  context '投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      basic_pass root_path
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')
    end
    it 'タイトルが空欄では投稿できない' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      fill_in 'item-name', with: ''
      select 'コスメ', from: 'item-category'
      # 送信してもArticleモデルのカウントが上がらないことを確認する
      expect { find('button[name="button"]').click }.to change { Article.count }.by(0)
      # 新規投稿ページに遷移することを確認する
      expect(current_path).to eq articles_path
    end
    it 'カテゴリーが空欄では投稿できない' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      fill_in 'item-name', with: @article.title
      # 送信してもArticleモデルのカウントが上がらないことを確認する
      expect { find('button[name="button"]').click }.to change { Article.count }.by(0)
      # 新規投稿ページに遷移することを確認する
      expect(current_path).to eq articles_path
    end
    it 'youtube_urlが不正な値では投稿できない' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      fill_in 'item-name', with: @article.title
      fill_in 'article_youtube_url', with: Faker::Internet.url
      select 'コスメ', from: 'item-category'
      # 送信してもArticleモデルのカウントが上がらないことを確認する
      expect { find('button[name="button"]').click }.to change { Article.count }.by(0)
      # 新規投稿ページに遷移することを確認する
      expect(current_path).to eq articles_path
    end
  end
end

RSpec.describe '投稿の編集', type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
    sleep(0.1)
  end

  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # @article1を投稿したユーザーでログインする
      sign_in(@article1.user)
      # @article1がトップページに存在することを確認する
      expect(page).to have_content(@article1.title)
      # @article1の詳細ページへ遷移する
      visit article_path(@article1)
      # 編集するのボタンがあることを確認する
      expect(page).to have_content('編集する')
      # 編集ページへ遷移する
      find('.edit-btn').click
      expect(current_path).to eq edit_article_path(@article1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(find('.youtube-upload').value).to eq(@article1.youtube_url)
      expect(find('.new-article-title').value).to eq(@article1.title)
      expect(find('.articles-trick').value).to eq(@article1.trick)
      # 投稿内容を編集する
      fill_in 'item-name', with: '編集テストです'
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect { find('button[name="button"]').click }.to change { Article.count }.by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq(article_path(@article1))
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content('編集テストです')
    end
  end
  context '編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # @article1を投稿したユーザーでログインする
      sign_in(@article1.user)
      # @article2の詳細ページへ移行する
      visit article_path(@article2)
      # 「編集する」ボタンがないことを確認する
      expect(page).to have_no_content('編集する')
    end
    it 'ログインしていないと編集画面には遷移できない' do
      # トップページにいる
      basic_pass root_path
      visit root_path
      # @article1がこのページにないことを確認する
      expect(page).to have_no_content(@article1)
      # @article2がこのページにないことを確認する
      expect(page).to have_no_content(@article2)
      # 強制的に@article1の詳細ページに遷移してもroot_pathに戻されていることを確認する
      visit article_path(@article1)
      expect(current_path).to eq(user_session_path)
    end
  end
end

RSpec.describe '削除', type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
    sleep(0.1)
  end

  context '削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した記事の削除ができる' do
      # @article1を投稿したユーザーでログインする
      sign_in(@article1.user)
      expect(current_path).to eq(root_path)
      # トップページに@article1の投稿があることを確認する
      expect(page).to have_content(@article1.title)
      # @article1の詳細ページに遷移する
      visit article_path(@article1)
      # 「削除」ボタンがあることを確認する
      expect(page).to have_link '削除する', href: article_path(@article1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect { find_link('削除する', href: article_path(@article1)).click }.to change { Article.count }.by(-1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには@article1が存在しないことを確認する
      expect(page).to have_no_content(@article1.title.to_s)
    end
  end
  context 'ツイート削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # @article1を投稿したユーザーでログインする
      sign_in(@article1.user)
      # @article２の詳細ページへ遷移する
      visit article_path(@article2)
      # @article２に「削除」ボタンが無いことを確認する
      expect(page).to have_no_content('削除する')
    end
    it 'ログインしていないと削除ボタンがない' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # @article1と@article2がこのページにないことを確認する
      expect(page).to have_no_content(@article1)
      expect(page).to have_no_content(@article2)
      # 各articleの詳細ページに遷移できない事を確認する
      visit article_path(@article1)
      expect(current_path).to eq(user_session_path)
      visit article_path(@article2)
      expect(current_path).to eq(user_session_path)
    end
  end
end
