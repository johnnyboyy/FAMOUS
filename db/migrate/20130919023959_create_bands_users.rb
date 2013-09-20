class CreateBandsUsers < ActiveRecord::Migration
  def change
    create_table :bands_users do |t|
    	t.integer :band_id
    	t.integer :user_id
    	
      t.timestamps
    end
  end
end
