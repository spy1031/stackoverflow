class AddStatusToUpvotes < ActiveRecord::Migration[5.1]
  def change
    add_column :upvotes, :status, :string, limit: 10
  end
end
