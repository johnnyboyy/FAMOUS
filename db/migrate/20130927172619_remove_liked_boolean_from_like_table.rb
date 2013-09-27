class RemoveLikedBooleanFromLikeTable < ActiveRecord::Migration
  def change
  	remove_column :likes, :liked
  end
end
