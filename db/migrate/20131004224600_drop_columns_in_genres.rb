class DropColumnsInGenres < ActiveRecord::Migration
  def change
  	remove_column :genres, :band_id_id
  	remove_column :genres, :song_id_id
  end
end
