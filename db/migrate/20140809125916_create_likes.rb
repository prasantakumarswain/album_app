class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :like, :default => 0, :null => false
      t.integer :unlike, :default => 0, :null => false
      t.integer :user_id
      t.integer :image_id
      t.integer :album_id

      t.timestamps
    end
  end
end
