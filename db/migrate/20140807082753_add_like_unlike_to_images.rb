class AddLikeUnlikeToImages < ActiveRecord::Migration
  def change
    add_column :images, :like, :integer, :default => 0, :null => false
    add_column :images, :unlike, :integer, :default => 0, :null => false
  end
end
