class Request < ActiveRecord::Base
  belongs_to :user, foreign_key: :sender
  has_many :users, foreign_key: :reciever

  validates_presence_of :request_type, :band_id, :status, :sender, :reciever
  validates_numericality_of :band_id, :reciever, :sender
  validate :status_must_be_correct, on: :create
  # validate :request_type_must_be_correct, on: :create


  def status_must_be_correct
    if status != 'pending'
      errors.add(:status, "must be set to pending!")
    end
  end
  # def request_type_must_be_correct
  #   if request_type != "member"
  #     errors.add(:status, "invalid request type!")
  #   elsif request_type != "booking"
  #     errors.add(:status, "invalid request type!")
  #   end
  # end

  def location
  end


  def requester_name
    User.find(self.sender).name
  end

  def band_name
    Band.find(self.band_id).name
  end
  
end
