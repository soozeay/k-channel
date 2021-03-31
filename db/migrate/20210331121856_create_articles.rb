class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title,      null: false
      t.text :text,         null: false
      t.text :ingredients,  null: false
      t.text :trick,        null: false
      t.integer :plaza_id,  null: false
      t.timestamps
    end
  end
end