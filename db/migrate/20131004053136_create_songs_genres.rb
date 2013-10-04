class CreateSongsGenres < ActiveRecord::Migration
  def change
    create_table :songs_genres do |t|
    	t.references :songs
    	t.references :genres

      t.timestamps
    end
  end
end
