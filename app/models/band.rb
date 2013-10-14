class Band < ActiveRecord::Base
	after_save :update_bands_songs
	has_many :bands_users
	has_many :users, through: :bands_users
	has_many :songs, dependent: :destroy
	has_many :genres, through: :songs
	has_many :albums


	validates_associated :songs
	validates :name, presence: true


	has_attached_file :profile_pic, default_url: 'band_silohuette.jpg'


	def fame
		fame = self.songs.inject(0) { |count, s| count += s.likes.count }
		self.fame = fame
		fame
	end

	def update_bands_songs
		unless self.songs.empty?
			self.songs.each do |s|
				s.artist = self.name
				s.save
			end
		end
	end


end
