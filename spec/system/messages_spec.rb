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
end

RSpec.describe "Messages", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)
    # 相手からのフォローを構築
    @relationship2 = Relationship.new(user_id: @another_user.id, follow_id: @user.id)
    sleep(0.1)
  end

  context 'メッセージができるとき' do
    it '相互フォロー同士でroomを生成し、メッセージのやりとりができる' do
      # ログインし、root_pathにいることを確認する
      sign_in(@user)
      # @another_userのページに遷移する
      visit user_path(@another_user)
      expect(current_path).to eq user_path(@another_user)
      # 「チャットへ」のボタンがあることを確認する
      expect(page).to have_selector(".follow-btn")
      find(".follow-btn").click
      expect(current_path).to eq user_path(@another_user)
      # 「チャットへ」のボタンがあることを確認する
      expect(page).to have_selector('.user-show-chat')
      find('.user-show-chat').click
      binding.pry
      # リロードする
      expect(current_path).to eq user_path(@another_user)
      visit current_path
      # 「チャットへ」のボタンがあることを確認する
      expect(page).to have_link('チャットへ')
    end
  end
end
