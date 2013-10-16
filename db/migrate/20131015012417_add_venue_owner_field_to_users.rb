class AddVenueOwnerFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_venue, :boolean
  end
end
