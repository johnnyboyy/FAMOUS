class Genre < ActiveRecord::Base

	# for the genres join table
	has_many :songs_genre
	has_many :genres, through: :songs_genre

	# validations
	

	
end
