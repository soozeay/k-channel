require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = FactoryBot.build(:article)
  end

  describe '記事の投稿機能' do
    context '記事が投稿できるとき' do
      it 'フォーム内の必要情報が全て存在すれば投稿できる' do
        expect(@article).to be_valid
      end
      it 'タイトル（title）とカテゴリー（plaza_id）があれば投稿できる' do
        @article.trick = ''
        @article.youtube_url = ''
        @article.image = ''
        expect(@article).to be_valid
      end
    end

    context '記事が登録できないとき' do
      it 'タイトル（title）が空欄では投稿できない' do
        @article.title = ''
        @article.valid?
        expect(@article.errors.full_messages).to include("タイトルを入力してください")
      end
      it 'タイトル（title）が40字を超えると投稿できない' do
        @article.title = Faker::Lorem.characters(number: 41)
        @article.valid?
        expect(@article.errors.full_messages).to include("タイトルは40文字以内で入力してください")
      end
      it 'ユーチューブのURL（youtube_url）がYoutube以外のURLでは投稿できない' do
        @article.youtube_url = Faker::Internet.url
        @article.valid?
        expect(@article.errors.full_messages).to include("Youtube urlは不正な値です")
      end
      it 'ユーチューブのURL（youtube_url）、チャンネルID（URLの下11桁）が11桁以外では投稿できない' do
        @article.youtube_url = "https://www.youtube.com/watch?v=" + Faker::Lorem.characters(number: 10, min_alpha: 10)
        @article.valid?
        expect(@article.errors.full_messages).to include("Youtube urlは不正な値です")
        @article.youtube_url = "https://www.youtube.com/watch?v=" + Faker::Lorem.characters(number: 12, min_alpha: 12)
        @article.valid?
        expect(@article.errors.full_messages).to include("Youtube urlは不正な値です")
      end
      it 'コツ（trick）が1,000字を超えると投稿できない' do
        @article.trick = Faker::Lorem.characters(number: 1001)
        @article.valid?
        expect(@article.errors.full_messages).to include("コツやポイントは1000文字以内で入力してください")
      end
      it 'タグが5つ以上では投稿できない' do
        @article.tag_list = %w[コスメ 美容 最新 要チェック 拡散希望 春の新作]
        @article.valid?
        expect(@article.errors.full_messages).to include('タグは５個までです')
      end
      it 'カテゴリ（plaza_id）が空では投稿できない' do
        @article.plaza_id = ''
        @article.valid?
        expect(@article.errors.full_messages).to include("記事のカテゴリーを入力してください", "記事のカテゴリーは数値で入力してください")
      end
      it 'カテゴリ（plaza_id）がid:0（"--"）では登録できない' do
        @article.plaza_id = 0
        @article.valid?
        expect(@article.errors.full_messages).to include("記事のカテゴリーは0以外の値にしてください")
      end

    end
  
  end
end
