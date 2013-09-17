class Song < ActiveRecord::Base

	has_attached_file :mp3_file	, :default_url => "/blank.mp3"

	validates :title, :artist, presence: true

	validates_attachment :mp3_file, :presence => true,
  :content_type => { :content_type => ["audio/mp3", "audio/x-m4a"] }
end
