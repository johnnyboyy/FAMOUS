class Song < ActiveRecord::Base

	validates :title, :artist, presence: true
end
