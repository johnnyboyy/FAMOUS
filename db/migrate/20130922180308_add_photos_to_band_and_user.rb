class AddPhotosToBandAndUser < ActiveRecord::Migration
  def change
  	add_column :bands, :profile_pic, :string
  	add_column :users, :profile_pic, :string
  end
end
