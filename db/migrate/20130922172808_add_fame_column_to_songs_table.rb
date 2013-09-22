class AddFameColumnToSongsTable < ActiveRecord::Migration
  def change
  	add_column :songs, :fame, :integer, default: 0
  end
end
