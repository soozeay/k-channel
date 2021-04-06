class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title,      null: false
      t.text :ingredients,  null: false
      t.text :trick,        null: false
      t.integer :plaza_id,  null: false
      t.references :user,   null: false, foreign_key: true
      t.string :youtube_url 
      t.timestamps
    end
  end
end