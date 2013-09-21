class User < ActiveRecord::Base
	has_many :bands_users
	has_many :bands, through: :bands_users
	has_many :songs, through: :bands
	
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
