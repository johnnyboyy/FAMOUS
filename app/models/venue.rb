class Venue < ActiveRecord::Base

		# to relate venues to users
		belongs_to :user

		# to allow users to like venues
		has_many :likes, through: :user

		has_attached_file :image 

		validates :name, :address, presence: true
		validates_attachment :image 
end
