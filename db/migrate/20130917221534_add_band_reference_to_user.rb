class AddBandReferenceToUser < ActiveRecord::Migration
  def change
  	add_column :users, :band_id, :integer
  end
end
