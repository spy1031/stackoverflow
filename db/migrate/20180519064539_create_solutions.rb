class CreateSolutions < ActiveRecord::Migration[5.1]
  def change
    create_table :solutions do |t|
      t.integer :user_id
      t.integer :question_id
      t.text    :content
      t.integer :upvotes_count

      t.timestamps
    end
  end
end
