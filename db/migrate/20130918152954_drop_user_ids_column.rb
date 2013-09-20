class DropUserIdsColumn < ActiveRecord::Migration
  def change
  	remove_column :bands, :user_ids
  end
end
