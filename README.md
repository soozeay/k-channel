# アプリケーション名
**『Kchannel』**<br><br>

# アプリケーション概要
このアプリケーションは韓国が好きな方々が集い、情報を発信・収集するアプリケーションサービスです。
発信・収集だけでなく、実際に韓国の方と繋がることで現地のトレンドをキャッチし、語学学習のチャンスも広がります。<br><br>

# URL
http://54.238.82.200/<br><br>

# テスト用アカウント
トップページから「ゲストユーザー」を選択してください<br><br>

# 利用方法
まずユーザー認証をする必要があります。新規登録・ログイン・ゲストログインから選び、認証を進めてください。
ログインが完了すると、全ての機能を使用する事ができます

## 記事投稿
ヘッダーの上部の投稿ボタンをクリックすると記事の投稿をすることができます。記事の投稿に必須なのはタイトルと記事のカテゴリー選択の２つです。
タイトルを入力すると記事を投稿することができます。カテゴリーは６つの中から適正なものを選び、投稿してください。どれにもあてはまらない場合は”その他”を選択してください。

## 記事一覧
投稿した自分の記事とフォローしたユーザーの記事のみがindexページに表示されます。サイドバーには表示を絞る為の項目を設けており、それをクリックすると「カテゴリ別」、「投稿ユーザーの地域別」、「地域別且つカテゴリ別」のパターンで表示することができます。（この時はフォローユーザーに限らず、全ての記事を閲覧いただけます。）

## 記事検索機能
ヘッダーにある検索バーで、ユーザー名、記事タイトル、タグの複合検索ができます。結果は全記事が表示されます。

## 記事詳細機能
記事詳細ページでは記事の閲覧、動画の視聴、いいね、コメントなどをすることができます。記事投稿者本人は記事の削除、編集をすることができます。

## 通知機能
自分が投稿した記事のコメント、いいねや自分に対するフォローには通知がきます。

## DM機能
フォローユーザー同士がDMでコミュニケーションを取ることができます。

## 添削機能 ※NEW
DM機能内で相手メッセージの添削ができます。

## 言語切替機能 ※NEW
日本語・韓国語の表示切替をボタンクリックできるようになりました。
ログアウト後の画面、各ページのヘッダーに設置されています。

## レスポンシブ対応 ※NEW
スマホ・タブレットに対応しました。

## いいねランキング機能 ※NEW
いいねの多いTOP10を合計、国別にそれぞれ閲覧することができます。
下記の詳細説明欄から操作方法をご確認ください。

## お問合せフォーム機能 ※NEW
トップページのリンクから、お問合せ内容を送信することができます。
フォーム送信後は、そのユーザーの登録しているメールに自動配信のリマインドメールが届くように設定されています。
また、管理人の私にもbccで配信されるように設定しています。

## パスワード再設定機能 ※NEW
新規登録時にパスワードを忘れてしまった場合、再設定をすることができます。
ログインページの「パスワードをお忘れの方はこちら」から申請いただくと、ご登録のメールアドレスに再設定用のURLを送付します。

## ニュース閲覧機能 ※NEW
ヘッダーの新聞アイコンをクリックすると、日韓両方のニュースを閲覧することができます。
ニュースページ内では、更に「エンタメ」「ビジネス」「テクノロジー」などのカテゴリー別に閲覧することができます。<br><br>


# 目指した課題解決
このアプリケーションは、以下2つの課題を解決する為に作成しました
```
①「日本で有名になった韓国料理店は実は現地の方は行かない」というギャップを埋めたい
```
「期待していたのに、味付けが日本人風味で残念だった」という声を参考にしました。
```
②独学でインプットのみしている韓国語をこの場でアウトプットすることで、添削を受けたり、コミュニケーションの練習をしたい
```
「スクールに通うのは恥ずかしい」、「もっと日常会話にフォーカスした表現の指導を受けたい」という声を参考にしました。
発信するだけでなく、アップデートを重ねることで皆さんに実りあるSNSサービスを作りたいです
このアプリケーションの企画書も合わせてご確認ください
https://docs.google.com/presentation/d/1JJVIfmAm8BPgtj0__QY0KKyYuCUGVRTdGEM2VzE8myQ/edit?usp=sharing<br><br>


|優先順位 3~1|機能        |目的         |詳細        |ストーリー |見積もり|
|--------------------------|----------- |------------|-----------|----------|------|
|3|出身地域を登録|繋がりたい相手を視覚的に判断しやすくする|ユーザーのアイコンへ出身地域別に国旗の画像を添付させる|ユーザー新規登録の際に、出身地域を選択できるセレクトボックスを配置する（この項目は変更不可とする）。|3時間|
|3|いいね機能|気に入った投稿記事にいいねを付与|マイページから後日確認することもできる|記事詳細ページにいいねアイコンを配置。投稿記事の詳細画面に入ると、いいねを押せるボタンが表示されている。いいねしたユーザーはマイページにその記事が保存されている。いいねされたユーザーには通知が届く。|1日|
|3|ユーザーフォロー機能|フォローしたユーザーの記事のみトップページに表示|トップページに表示されている記事は自身のフォローユーザーの投稿に限る|新規登録したばかりや、フォローを持たないユーザーはトップページには何も表示されない（検査して全件表示することは可能）。記事を検索し、気にいったユーザーをフォローするとトップページに表示される様になる。|1日|
|2|コメント機能|投稿記事にコメントができる|質問や訂正依頼ができる|記事詳細ページ右側にコメント欄を設置。感想を残す、質問をする、間違いの指摘を残せる。記事詳細ページにコメント欄が見えている。フォームにコメントを入力し送信。最新コメントは画面下に表示される。|6時間|
|3|タグ付け機能|記事に関連タグを付与し、検索されやすくする。また、タイトルで伝えきれなかった補足や思いを端的に綴れる。|記事投稿画面にタグの入力欄を付与（5つまでと制限する）。カンマ "," を打つと区切ることができる。|新規投稿フォームの画面下部にタグ入力欄がある。好きな単語を入力する（#は不要）。閉じたい時はカンマ "," を打つ。削除したい場合は×ボタンを押す。|1日|
|2|DM機能|相互フォローユーザーに限りメッセージの送付ができる|記事のコメントではなく、二人のみ閲覧できるメッセージルームを生成し、チャットのやりとりができる|相互フォローとなった時にユーザー詳細ページに「メッセージをする」というボタンが表示される。そのボタンを押すことでトークルームにエントリーされる。ルームに入室後はフォームにメッセージを入力し、送信ボタンを押下するとメッセージが送信される。トップページ右上のレターアイコンからもメッセージルームに入室することができる。|6時間|
|3|Youtube動画のリンク貼り付け|記事にYoutubeのリンクを付与すると詳細画面で動画を閲覧することができる|画像ではなく、動画で説明や紹介をしたい方を想定し、YoutubeのURLを添付できる様にする（トップページのサムネイルには表示されないが「動画有」のマークが付く。閲覧者は詳細ページに遷移すると動画を視聴できる|【投稿者】YoutubeのURLを入手する。記事投稿ページのURL添付欄に添付し送信。【閲覧者】トップページの「動画有」マークから動画が見れることを認識。記事詳細ページに遷移し、Youtube再生ボタンをタップし視聴|4時間|
|3|複雑検索|一つの検索ボックスで何でも検索できる様にする|トップページのヘッダーに検索BOXを付与。ユーザー名、記事のタイトル、タグなどの必要なキーワードを入力するとトップページに該当の記事が表示される|検索フォームに欲しいキーワードを入力する。Enterを押すか、虫眼鏡マークを押すことで検索が実行。検索結果はトップページに該当記事を一覧表示する（ユーザー名検索の場合は、そのユーザーの投稿記事一覧が表示される）。|6時間|
|2|マイページのSPA化|自身の投稿記事一覧・フォローしているユーザー・フォローされているユーザー・いいねした記事の4機能をページ遷移せずタブで選択し閲覧できる様にする|マイページに遷移すると画面中央部にタブが４つ表示されている|閲覧したい箇所のボタンを押すと、その情報の表示に切替る（画面遷移はしない）。|6時間|
|3|ユーザーの地域別に表示を切替|相手国出身の投稿記事のみを閲覧できるようにする|トップページで地域別に表示を切替できるようにする|トップページのサイドバーにあるボタンを選択する。|6時間|


# 実装した機能について
## 記事投稿機能
![ace55a3c9e92063a3a125e27caed4959](https://user-images.githubusercontent.com/80019801/116359850-3ffc4900-a83a-11eb-9c5c-5135bd93b18f.gif)
このように、画像だけでなくYoutubeのURLを添付することもできます。また、Action textを用いて記事の本文をアレンジすることができます。
動画と画像を両方添付した場合、画像はサムネイルとして活用され、記事本文には表示されません。

## 記事一覧表示機能
![13d596b4556afdd6d61a712527f7e9fe](https://user-images.githubusercontent.com/80019801/116361811-5905f980-a83c-11eb-9049-3808d14763d2.gif)
このようにトップページに投稿記事一覧が表示されます。表示されるのは①自身の投稿、②フォローしたユーザーの投稿に限られます。画面左のバーから地域別・カテゴリ別に記事を絞り、フォローしていないユーザーの投稿を閲覧することも可能です

## タグ検索機能
![c821b92b1094dad7139b9046f6781ff8](https://user-images.githubusercontent.com/80019801/116508002-6209d000-a8fb-11eb-9324-1317bafa80cc.gif)
このようにタグをクリックするとタグ検索ができます。また、画面上部のフォームに入力して検索することも可能です。

## 記事検索機能
![05b4f1bc998b66b3e232f6258f5568e8](https://user-images.githubusercontent.com/80019801/116508183-b8770e80-a8fb-11eb-98bc-4c39736d9015.gif)
ヘッダーにある検索フォームをクリックすると、ユーザー名とタグ、記事のタイトルを元に複合検索ができます。

## 記事詳細機能
![60859e8928860c0bae0a8f50ff3fe642](https://user-images.githubusercontent.com/80019801/116508290-f6743280-a8fb-11eb-88bd-0af727ece981.gif)
このように記事は詳細表示されます。いいねボタンを押下することも可能です。
また、右側にコメント欄を設けており、質問や間違いの指摘も可能です。

## 地域別の表示切替機能
![76e19131aff4e5b892c7cc907988e233](https://user-images.githubusercontent.com/80019801/116518405-270f9880-a90b-11eb-833c-eb0ffb89f8b5.gif)
このようにトップページのサイドバーから「日本人ユーザー」「韓国人ユーザー」に分けた表示ができます。この場合は関連する全投稿が表示されます

## ユーザーページ
![ccef485c325514e511e625a1aff8f311](https://user-images.githubusercontent.com/80019801/116510981-bc595f80-a900-11eb-9863-cff65ff9ec56.gif)
投稿に紐づくユーザーをクリックするとユーザーページに遷移します。そこでは、そのユーザーが投稿した記事一覧とフォローユーザー一覧とフォロワー一覧、いいねした記事の一覧がタブで表示切り替えをすることが可能です。フォローする・フォロー解除するというボタンも設置されています。相互フォローとなった場合は「チャットへ」のボタンが表示され、DMでのやりとりが可能です

## マイページ
![60a0f2dd5ded0457a465a35c89698bf6](https://user-images.githubusercontent.com/80019801/116511139-f460a280-a900-11eb-8d5e-752a317539de.gif)
ヘッダーのアバター画像をクリックすると、マイページへ遷移することができます。ユーザーの編集のリンクが存在します。ここからカバー画像やアバターの設定、自己紹介文の入力ができる様になります。

## 通知機能
![71602fa8077c73cb6d6acf44671cc42c](https://user-images.githubusercontent.com/80019801/116511355-499cb400-a901-11eb-8c6c-ad91c4d7a3a0.gif)
ヘッダーのベルマークをクリックすれば、通知一覧に遷移できます。
通知が届くアクションは「フォローされた」「記事にいいねされた」「記事にコメントが付いた」の３点です

## 添削機能
![8cbbc11195c357e23f4207cfd49ab4de](https://user-images.githubusercontent.com/80019801/120970691-b891e600-c7a6-11eb-9ed2-880e2e998000.gif)
![9ff67b70cbd919324e1d986573318d18](https://user-images.githubusercontent.com/80019801/120970891-fb53be00-c7a6-11eb-95d4-b24a91c83443.gif)
このように、対象のメッセージから「添削」のボタンをクリックすると、相手メッセージの間違いを指摘することができます。
添削元は文字色を赤くし、取り消し線を入れています。

## 言語切替機能
![5490c9499afd5c1feb1042e9b99c9ec0](https://user-images.githubusercontent.com/80019801/121842984-5b54e200-cd1c-11eb-94b4-319b9a875772.gif)
![deb292f434050b8dcf951bf11b1df937](https://user-images.githubusercontent.com/80019801/121843096-9ce58d00-cd1c-11eb-9b44-0b86de448f69.gif)
このように、画面上の言語切替ボタンをクリックすると表示言語を切り替えることができます。
デフォルトは日本語に設定されています。

## いいねランキング表示機能
![3f42f9004d55360a1fbc4de726df8169](https://user-images.githubusercontent.com/80019801/121870391-f8744280-cd3d-11eb-80f3-f415541dbf36.gif)
![79a9247954c037b8f8e6541e02d0be8c](https://user-images.githubusercontent.com/80019801/121870595-2c4f6800-cd3e-11eb-9239-7d343ca2608c.gif)
![92c45422814fc3dbdb741ee1c39a45ec](https://user-images.githubusercontent.com/80019801/121870753-5143db00-cd3e-11eb-9290-58bd7b091f39.gif)
このように、画面のサイドバーから「いいねランキング」を表示することができます。
全ての中からのランキング、国別のランキングを閲覧することが可能です。

## お問合せ機能
![ea24023244e9b88ce6bca957f803950a](https://user-images.githubusercontent.com/80019801/122075008-aeba5380-ce34-11eb-84fb-146c8c6a4d78.gif)
![990aa8eeddf42cff53d36c1430ccc07b](https://user-images.githubusercontent.com/80019801/122075481-11abea80-ce35-11eb-8387-4b707864c076.gif)
![4c325f983a957293a446372a19878e85](https://user-images.githubusercontent.com/80019801/122075808-4f107800-ce35-11eb-9825-8dc56f1e285e.gif)
このように、入力フォームからお問合せの内容を運営者へ送信することができます。
アプリケーションの不具合、スパムユーザーなどの報告はこちらのフォームから連絡をいただきますようお願い申し上げます。

## パスワード再設定機能
![6b4b8861cb58a6a8fac9ad41e78a5822](https://user-images.githubusercontent.com/80019801/122198058-c563b780-ced3-11eb-9352-192253cc7ddd.gif)
![a490a71337bfcbb875187c6889cc374e](https://user-images.githubusercontent.com/80019801/122198227-f04e0b80-ced3-11eb-85b5-7703e10e7714.gif)
![09c0babad27552f68ae4f08909b61b15](https://user-images.githubusercontent.com/80019801/122198407-1a073280-ced4-11eb-9bf5-883a0a460262.gif)
![e87403b0839441867204ff8163b8bad8](https://user-images.githubusercontent.com/80019801/122198656-4a4ed100-ced4-11eb-9a67-d496008f08e1.gif)
このように、ログイン画面からパスワード再設定の申請をすることができます。ご登録済みのメールアドレスのみ入力することができるようになっています。
メールが届きましたら、添付のリンク内のフォームから新しいパスワードを入力し、ログインを行ってください。

## ニュース閲覧機能
![2ec5e5416937f39868d2120e94cb25db](https://user-images.githubusercontent.com/80019801/123572020-61f85480-d806-11eb-90f9-480395235793.gif)
![c5827ff562a049539288a8f376fee415](https://user-images.githubusercontent.com/80019801/123572134-9ff57880-d806-11eb-936d-609b517c0f04.gif)
![a1bfbfef0b9b77b34c5a7756cd5a4ffe](https://user-images.githubusercontent.com/80019801/123572243-d501cb00-d806-11eb-95c3-6eeb5f6e8e38.gif)
このように、ヘッダーの新聞アイコンをクリックするとニュースを閲覧することができます。
ニュース内から6つのカテゴリーでニュースを切替表示することが可能です。韓国のニュースも表示することができます。<br><br>


# テーブル設計
## ER図
![er-kchannel](https://user-images.githubusercontent.com/80019801/121843374-10879a00-cd1d-11eb-81bb-cc35e152bcf4.png)


## users テーブル
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| age                | integer |                           |
| country_id         | integer | null: false               |
| gender_id          | integer | null: false               |
| intro              | string  |                           |

avatar,coverはActive Storageを使用

### Association
- belongs_to :gender
- belongs_to :country
- has_many: articles, dependent: :destroy
- has_many: comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :liked_articles, through: :likes, source: :article
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user
- has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
- has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
- has_many :messages, dependent: :destroy
- has_many :entries, dependent: :destroy
- has_many :rooms, through: :entries


## articlesテーブル
| Column      | Type       | Options                       |
| ----------- | ---------- | ------------------------------|
| title       | string     | null: false                   |
| youtube_url | string     | default: ""                   |
| trick       | text       |                               |
| plaza_id    | integer    | null:  false                  |
| user        | references | null: false foreign_key: true |

text（本文）はAction Textを使用
image（サムネイル）はActive Storageを使用

### Association
- belongs_to: user
- belongs_to: plaza
- has_many: comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :liked_users, through: :likes, source: :user
- has_many :notifications, dependent: :destroy


## comments テーブル
| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| comment | text       | null: false                   |
| user    | references | null: false foreign_key: true |
| article | references | null: false foreign_key: true |

### Association
- belongs_to: user
- belongs_to: article
- has_many :notifications, dependent: :destroy


## likes テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| user    | references | foreign_key: true |
| article | references | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :article


## notifications テーブル
| Column  | Type       | Options                     |
| ------- | ---------- | --------------------------- |
| visitor | references | null: false                 |
| visited | references | null: false                 |
| article | references |                             |
| comment | references |                             |
| action  | string     | default: "", null: false    |
| checked | boolean    | default: false, null: false |


### Association
- belongs_to :article, optional: true
- belongs_to :comment, optional: true
- belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
- belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true


## relationships テーブル
| Column  | Type       | Options                           |
| ------- | ---------- | --------------------------------- |
| user    | references | foreign_key: true                 |
| follow  | references | foreign_key: { to_table: :users } |

### Association
- belongs_to :user
- belongs_to :follow, class_name: 'User'


## rooms テーブル
idのみ

### Association
- has_many :messages, dependent: :destroy
- has_many :entries, dependent: :destroy
- has_many :users, through: :entries

## entries テーブル
| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| user    | references | foreign_key: true |
| room    | references | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :room

## messages テーブル
| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| user           | references | foreign_key: true |
| room           | references | foreign_key: true |
| message        | text       | null: false       |
| target_message | text       |                   |

## タグについて
タグに関してはgemの"acts-as-tagable-on"を使用。

## contacts テーブル
| Column  | Type   | Options     |
| ------- | ------ | ----------- |
| name    | string | null: false |
| content | text   | null: false |