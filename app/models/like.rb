class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :song


	# validations:
	validates :liked, :song_id, :user_id, presence: true


end
