class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :friender_id
      t.integer :friendee_id
      t.integer :friendship_id
      t.boolean :status, default: false
      t.timestamps
    end
    add_index :friendships, :friender_id
    add_index :friendships, :friendee_id
    add_index :friendships, :friendship_id, unique: true
  end
end
