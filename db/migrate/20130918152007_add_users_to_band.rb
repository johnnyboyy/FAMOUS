class AddUsersToBand < ActiveRecord::Migration
  def change
  	add_column :bands, :user_ids, :integer
  end
end
