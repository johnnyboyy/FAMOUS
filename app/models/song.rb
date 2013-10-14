class Song < ActiveRecord::Base
	# to relate songs band and song
	belongs_to :album
	belongs_to :user
	belongs_to :band

	# to allow users to like songs
	has_many :likes, dependent: :destroy
	has_many :users, through: :likes

	# to allow songs to have genres through the
	# join table -- songs_genres
	has_many :songs_genres
	has_many :genres, through: :songs_genres
	after_save :update_genres


	# to upload a file using paperclip gem
	has_attached_file :mp3_file	

	# validations:
	validates :title, :artist, presence: true
	validates_attachment :mp3_file, :presence => true,
  :content_type => { :content_type => ["audio/mp3", "audio/x-m4a"] }

  paginates_per(5)
  
	def updated_fame
		self.fame = self.likes.count
	end

	def genres_list
  	genres.map(&:name).map(&:titleize).join(", ")
	end

	def genres_list=(names)
	  self.genres = names.split(",").map do |n|
	    Genre.where(name: n.strip.downcase).first_or_create!
	  end
	end

	def update_genres
		self.genres.each do |g|
			g.update_count_field
		end
	end
end
