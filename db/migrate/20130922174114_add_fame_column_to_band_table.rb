class AddFameColumnToBandTable < ActiveRecord::Migration
  def change
    add_column :bands, :fame, :integer, default: 0
  end
end
