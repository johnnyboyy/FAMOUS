class Genre < ActiveRecord::Base
	has_many :songs_genres
	has_many :songs, through: :songs_genres
  has_many :bands, through: :songs


  def update_count_field
    self.count = self.songs.count
    self.save    
  end
end
