class Request < ActiveRecord::Base
  belongs_to :user, foreign_key: :sender
  has_many :users, foreign_key: :reciever


end
