class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.attachment :artwork
      t.string :title

      t.timestamps
    end
  end
end
