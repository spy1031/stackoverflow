class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.integer :upvotes_count, default: 0
      t.integer :favorites_count, default: 0
      t.integer :solutions_count, default: 0
      t.timestamps
    end
  end
end
