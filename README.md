# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## users テーブル
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| age                | integer |                           |
| country_id         | integer | null: false               |
| gender_id          | integer | null: false               |

### Association
- has_many: plazas, through: plaza_users
- has_many: articles
- has_many: comments


## plazas テーブル
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| name               | string  | null: false               |

### Association
- has_many: users, through: plaza_users
- has_many: articles
- has_many: comments


## articlesテーブル
| Column      | Type       | Options                       |
| ----------- | ---------- | ------------------------------|
| title       | string     | null: false                   |
| text        | text       | null: false                   |
| ingredients | text       | null: false                   |
| trick       | text       | null: false                   |
| plaza_id    | integer    | null:  false                  |
| user        | references | null: false foreign_key: true |

### Association
- belongs_to: user
- belongs_to: plaza
- has_many: comments


## comments テーブル
| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| comment | text       | null: false                   |
| user    | references | null: false foreign_key: true |
| article | references | null: false foreign_key: true |

### Association
- belongs_to: user
- belongs_to: plaza
- belongs_to: article