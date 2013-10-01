class RemoveProfilePicFromBandsAndAddAttachmentForPapaerclip < ActiveRecord::Migration
  def change
  	remove_column :bands, :profile_pic
  	add_attachment :bands, :profile_pic
  end
end
