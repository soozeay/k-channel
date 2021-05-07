require 'rails_helper'

def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

def sign_in(user)
  visit new_user_session_path
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password
  find('input[name="commit"]').click
  expect(current_path).to eq root_path
  expect(page).to have_no_content('ログイン')
end

def sign_out
  # ページヘッダーからマイページへのリンクを特定する
  expect(page).to have_selector(".user-nickname")
  find('.user-nickname').click
  # サインアウトする
  expect(page).to have_selector(".sign-out")
  find('.sign-out').click
  expect(current_path).to eq root_path
end

RSpec.describe "Messages", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)
    @message = FactoryBot.build(:message)
    sleep(0.1)
  end

  context 'メッセージができるとき' do
    it '相互フォロー同士でroomを生成し、メッセージのやりとりができる' do
      # @another_userでログインする
      basic_pass root_path
      visit root_path
      sign_in(@another_user)
      # @userの詳細ページへ遷移する
      visit user_path(@user)
      # @userをフォローするボタンがあることを確認する
      expect(page).to have_selector(".follow-btn")
      # @userをフォロー、Relationshipカウントが1上がることを確認する
      expect{find('.follow-btn').click}.to change { Relationship.count }.by(1)
      # @another_userはマイページに戻り、ログアウトする
      sign_out
      # @userでログインする
      sign_in(@user)
      # @another_userからフォローされていることを確認する
      expect(page).to have_selector('.notification-icon')
      find('.notification-icon').click
      expect(current_path).to eq notifications_path
      expect(page).to have_content("#{@another_user.nickname} さんが あなたをフォローしました")
      # @another_userのページに遷移する
      visit user_path(@another_user)
      expect(current_path).to eq user_path(@another_user)
      # 「フォローする」のボタンがあることを確認する
      expect(page).to have_selector(".follow-btn")
      # @another_userをフォローする ページは遷移していないことを確認する
      expect{find('.follow-btn').click}.to change { Relationship.count }.by(1)
      expect(current_path).to eq user_path(@another_user)
      # ページに「チャットを始める」のボタンが出現していることを確認する
      expect(page).to have_selector('.user-show-chat')
      # 「チャットを始める」をクリックし、room#indexに遷移していることを確認する
      find('.user-show-chat').click
      expect(page).to have_content('メッセージはありません')
      # メッセージの入力フォームを特定する
      expect(page).to have_selector('.form-text-field')
      # メッセージフォームに入力し、送信する。Messageカウントが1上がることを確認する
      fill_in 'メッセージを入力して下さい', with: @message.message
      expect{find('.posts').find('button[name="button"]').click}.to change { Message.count }.by(1)
      # このページに@message.messageが存在していることを確認
      expect(page).to have_content(@message.message)
      # サインアウトする（@another_userでメッセージの存在を確認していく）
      sign_out
      # 再び@another_userでサインインする
      sign_in(@another_user)
      # 画面ヘッダーにあるレターアイコンから、メッセージ機能のページへ遷移していく
      expect(page).to have_selector('.message-icon')
      find('.message-icon').click
      expect(current_path).to eq rooms_path
      # @userとのメッセージルームへ遷移していく
      expect(page).to have_link(@user.nickname)
      find('.room').click
      # ページに先ほどの@message.messageが存在するか確認する
      expect(page).to have_content(@message.message)
    end
  end
  context 'メッセージができないとき' do
    it '@userが@another_userをフォローしていないとroomに入ってもメッセージができない' do
      # @another_userでログインする
      basic_pass root_path
      visit root_path
      sign_in(@another_user)
      # @userの詳細ページへ遷移する
      visit user_path(@user)
      # @userをフォローするボタンがあることを確認する
      expect(page).to have_selector(".follow-btn")
      # @userをフォロー、Relationshipカウントが1上がることを確認する
      expect{find('.follow-btn').click}.to change { Relationship.count }.by(1)
      # @another_userはマイページに戻り、ログアウトする
      sign_out
      # @userでログインする
      sign_in(@user)
      # @another_userからフォローされていることを確認する
      expect(page).to have_selector('.notification-icon')
      find('.notification-icon').click
      expect(current_path).to eq notifications_path
      expect(page).to have_content("#{@another_user.nickname} さんが あなたをフォローしました")
      # トップページに戻り、メッセージルームのページに遷移する
      visit root_path
      expect(page).to have_selector('.message-icon')
      find('.message-icon').click
      expect(current_path).to eq rooms_path
      # このページに@another_userとのルームが存在しないことを確認する
      expect(page).to have_no_link(@user.nickname)
    end
    it 'ログインしていないユーザーがトップページから強制的にrooms_pathに遷移してもできない' do
      basic_pass root_path
      visit root_path
      visit rooms_path
      expect(current_path).to eq new_user_session_path
    end
    it '空欄のメッセージは送信できない' do
      # @another_userでログインする
      basic_pass root_path
      visit root_path
      sign_in(@another_user)
      # @userの詳細ページへ遷移する
      visit user_path(@user)
      # @userをフォローするボタンがあることを確認する
      expect(page).to have_selector(".follow-btn")
      # @userをフォロー、Relationshipカウントが1上がることを確認する
      expect{find('.follow-btn').click}.to change { Relationship.count }.by(1)
      # @another_userはマイページに戻り、ログアウトする
      sign_out
      # @userでログインする
      sign_in(@user)
      # @another_userからフォローされていることを確認する
      expect(page).to have_selector('.notification-icon')
      find('.notification-icon').click
      expect(current_path).to eq notifications_path
      expect(page).to have_content("#{@another_user.nickname} さんが あなたをフォローしました")
      # @another_userのページに遷移する
      visit user_path(@another_user)
      expect(current_path).to eq user_path(@another_user)
      # 「フォローする」のボタンがあることを確認する
      expect(page).to have_selector(".follow-btn")
      # @another_userをフォローする ページは遷移していないことを確認する
      expect{find('.follow-btn').click}.to change { Relationship.count }.by(1)
      expect(current_path).to eq user_path(@another_user)
      # ページに「チャットを始める」のボタンが出現していることを確認する
      expect(page).to have_selector('.user-show-chat')
      # 「チャットを始める」をクリックし、room#indexに遷移していることを確認する
      find('.user-show-chat').click
      expect(page).to have_content('メッセージはありません')
      # メッセージの入力フォームを特定する
      expect(page).to have_selector('.form-text-field')
      # メッセージフォームに''を入力し、送信する。Messageカウントは上がらないことを確認する
      fill_in 'メッセージを入力して下さい', with: ''
      expect{find('.posts').find('button[name="button"]').click}.to change { Message.count }.by(0)
      # このページに@message.messageが存在していることを確認
      expect(page).to have_no_content(@message.message)
      # サインアウトする（@another_userでメッセージの存在を確認していく）
      sign_out
      # 再び@another_userでサインインする
      sign_in(@another_user)
      # 画面ヘッダーにあるレターアイコンから、メッセージ機能のページへ遷移していく
      expect(page).to have_selector('.message-icon')
      find('.message-icon').click
      expect(current_path).to eq rooms_path
      # @userとのメッセージルームへ遷移していく
      expect(page).to have_link(@user.nickname)
      find('.room').click
      # ページに@messageも存在しないことを確認する
      expect(page).to have_no_content(@message.message)
    end
  end
end
