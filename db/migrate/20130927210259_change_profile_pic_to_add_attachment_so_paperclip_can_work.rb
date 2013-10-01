class ChangeProfilePicToAddAttachmentSoPaperclipCanWork < ActiveRecord::Migration
  def change
  	remove_column :users, :profile_pic
  	add_attachment :users, :profile_pic
  end
end
