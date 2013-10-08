class User < ActiveRecord::Base
	has_many :bands_users
	has_many :bands, through: :bands_users
	has_many :songs, through: :bands
  has_many :venues 

	has_many :likes
	has_many :songs, through: :likes
	
	has_attached_file :profile_pic, default_url: "Famous_Silohuette.png"
	
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def liked_bands
  	bands = []
  	self.likes.map(&:song).compact.inject(bands) { |bands, s| bands << s.band }
  	bands.uniq
  end

  def name
    return "#{first_name} #{last_name}"
  end
end
