class ChangeSongsIdAndGenresIdToSingular < ActiveRecord::Migration
  def change
  	change_table :songs_genres do |t|
  		t.rename :songs_id, :song_id
  		t.rename :genres_id, :genre_id
  	end
  end
end
