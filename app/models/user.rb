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
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :requests, foreign_key: :sender
  has_many :requests, source: :user, foreign_key: :reciever


  # start of twitter logins
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      
    end
  end       

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end

  def password_required?
    super && provider.blank?
  end

   # def email_required? #<---to skip email validation
   #   super && provider.blank?
   # end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
  # end of twitter login


  def set_venue_status
    self.has_venue = true
    self.save
  end


  def liked_bands
  	bands = []
  	self.likes.map(&:song).compact.inject(bands) { |bands, s| bands << s.band }
  	bands.uniq
  end

  def name
    return "#{first_name} #{last_name}"
  end

  def recieved_requests
    Request.where(reciever: self)
  end

  def sent_requests
    requests = []
    Request.where(sender: self.id).each do |req|
      unless requests.map(&:band_id).include?(req.band_id) && requests.map(&:showtime).include?(req.showtime)
        requests << req
      end
    end
    requests
  end


  def public_songs
    #songs by all bands the user is in, sorted by most famous
    Song.where(band_id: self.bands.map(&:id)).order('fame DESC')
  end

  def is_member_of?(band)
    band.users.include?(self)
  end
end
