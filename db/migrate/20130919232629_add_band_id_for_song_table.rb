class DropArtistAndAddBandIdForSongTable < ActiveRecord::Migration
  def change

  	add_column :songs, :band, :reference
  end
end
