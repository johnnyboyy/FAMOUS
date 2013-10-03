class Song < ActiveRecord::Base
	# to relate songs band and song
	belongs_to :user
	belongs_to :band

	# to allow users to like songs
	has_many :likes, dependent: :destroy
	has_many :users, through: :likes

	# to upload a file using paperclip gem
	has_attached_file :mp3_file	, default_url: "/blank.mp3"

	# validations:
	validates :title, :artist, presence: true
	validates_attachment :mp3_file, :presence => true,
  :content_type => { :content_type => ["audio/mp3", "audio/x-m4a"] }
  
	def updated_fame
		self.fame = self.likes.count
	end


end
