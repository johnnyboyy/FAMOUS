class Request < ActiveRecord::Base
  belongs_to :user, foreign_key: :sender
  has_many :users, foreign_key: :reciever

  validates_presence_of :request_type, :band_id, :status, :sender, :reciever
  validates_numericality_of :band_id, :reciever, :sender
  validate :status_must_be_correct, on: :create
  validate :request_type_must_be_correct, on: :create
  validates :pay, :per, :showtime, :location, presence: true, if: :is_booking_request?


  def status_must_be_correct
    if status != 'pending'
      errors.add(:status, "must be set to pending!")
    end
  end

  def request_type_must_be_correct
    acceptable_types = ["member", "booking"]
    unless acceptable_types.include?(self.request_type)
      errors.add(:status, "invalid request type!")
    end
  end

  def is_booking_request?
    self.request_type == 'booking'
  end


  def booking_message
    self.message = "#{self.requester_name} is willing to pay $#{self.pay}
       for #{self.per} for you to play a show
       at #{self.location}, on #{self.showtime.strftime(format='%m/%e/%Y')}."
  end


  def requester_name
    User.find(self.sender).name
  end

  def band_name
    Band.find(self.band_id).name
  end


  
end
