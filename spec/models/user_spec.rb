require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'フォーム内の必要情報が全て存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it '自己紹介（intro）が空欄でも登録できる' do
        @user.intro = ''
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネーム（nickname）が空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'emailに@が含まれないと登録できない' do
        @user.email = 'aagmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it '重複するEmailは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが存在してもパスワード確認用（password_confirmation）が空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordに半角英字が1文字以上含まれないと登録できない' do
        @user.password = Faker::Number.number(digits: 6)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'passwordに半角数字が1文字以上含まれないと登録できない' do
        @user.password = Faker::Lorem.characters(number: 6, min_alpha: 6)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'aaa00'
        @user.password_confirmation = 'aaa00'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordは全角英語では登録できない' do
        @user.password = 'ａａａａ0000'
        @user.password_confirmation = 'ａａａａ0000'
        @user.valid?
        binding.pry
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it '年齢（age）が空では登録できない' do
        @user.age = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("年齢は数値で入力してください")
      end
      it '年齢（age）が20歳未満又は120歳以上は登録できない' do
        @user.age = 19
        @user.valid?
        expect(@user.errors.full_messages).to include("年齢は20以上の値にしてください")
        @user.age = 121
        @user.valid?
        expect(@user.errors.full_messages).to include("年齢は120以下の値にしてください")
      end
      it '年齢（age）が全角数字では登録できない' do
        @user.age = '２２'
        @user.valid?
        expect(@user.errors.full_messages).to include("年齢は数値で入力してください")
      end
      it '年齢（age）が平仮名では登録できない' do
        @user.age = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include("年齢は数値で入力してください")
      end
      it '年齢（age）がカタカナでは登録できない' do
        @user.age = 'アイウエオ'
        @user.valid?
        expect(@user.errors.full_messages).to include("年齢は数値で入力してください")
      end
      it '年齢（age）が半角英字では登録できない' do
        @user.age = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("年齢は数値で入力してください")
      end
      it '年齢（age）が全角英字では登録できない' do
        @user.age = 'ａｂｃ'
        @user.valid?
        expect(@user.errors.full_messages).to include("年齢は数値で入力してください")
      end
      it '性別（gender_id）が空では登録できない' do
        @user.gender_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("性別を入力してください", "性別は数値で入力してください")
      end
      it '性別（gender_id）がid:0（"--"）では登録できない' do
        @user.gender_id = 0
        @user.valid?
        expect(@user.errors.full_messages).to include("性別は0以外の値にしてください")
      end
      it '地域（country_id）が空では登録できない' do
        @user.country_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("地域を入力してください", "地域は数値で入力してください")
      end
      it '地域（country_id）がid:0（"--"）では登録できない' do
        @user.country_id = 0
        @user.valid?
        expect(@user.errors.full_messages).to include("地域は0以外の値にしてください")
      end
    end
  end
end
