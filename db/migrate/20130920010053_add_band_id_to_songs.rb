class AddBandIdToSongs < ActiveRecord::Migration
  def change
  	add_column :songs, :band_id, :integer
  end
end
