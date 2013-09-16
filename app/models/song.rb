class Song < ActiveRecord::Base

	validates :title, :artist, presence: true

	has_attached_file :mp3_file	, :default_url => "/blank.mp3"
end
