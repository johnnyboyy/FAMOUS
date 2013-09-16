class AddAttachmentsToSong < ActiveRecord::Migration
  def change
    add_attachment :songs, :mp3_file
  end
end
