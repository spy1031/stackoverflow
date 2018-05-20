class CreateUpvotes < ActiveRecord::Migration[5.1]
  def change
    create_table :upvotes do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :solution_id

      t.timestamps
    end
  end
end
