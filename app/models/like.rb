class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :song


	# validations:
	validates :song_id, :user_id, presence: true
	validates_uniqueness_of :user_id, scope: :song_id


end
