class Band < ActiveRecord::Base
	has_many :users
	has_many :songs, through: :users
end
