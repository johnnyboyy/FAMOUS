class Album < ActiveRecord::Base
  has_many :songs
  belongs_to :band

  validates :title, presence: true

  has_attached_file :profile_pic

end
