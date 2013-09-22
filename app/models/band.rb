class Band < ActiveRecord::Base
	has_many :bands_users
	has_many :users, through: :bands_users
	has_many :songs

	validates_associated :songs
	validates :name, presence: true





	def fame
		fame = self.songs.inject(0) { |count, s| count += s.likes.count }
		self.fame = fame
		fame
	end

end
