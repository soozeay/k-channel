require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @new_user = FactoryBot.build(:user)
    @user = FactoryBot.create(:user)
  end

  def basic_pass(path)
    username = ENV['BASIC_AUTH_USER']
    password = ENV['BASIC_AUTH_PASSWORD']
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しく情報を入力すれば新規登録ができる' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'name', with: @new_user.nickname
      fill_in 'email', with: @new_user.email
      fill_in 'password', with: @new_user.password
      fill_in 'password-confirmation', with: @new_user.password_confirmation
      fill_in 'age', with: @new_user.age
      select '男性', from: 'gender-status'
      select '日本', from: 'country-status'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect { find('input[name="commit"]').click }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # カーソルを合わせるとマイページが表示されることを確認する
      expect(find('.lists-right').find('.user-nickname').hover).to have_content('マイページ')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録できないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する（今回は空入力で進めていく）
      fill_in 'name', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      fill_in 'age', with: ''
      select '男性', from: 'gender-status'
      select '日本', from: 'country-status'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect { find('input[name="commit"]').click }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
  context '登録済みの@userでログインできるとき' do
    it '情報を正しく入力すればログインできる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
