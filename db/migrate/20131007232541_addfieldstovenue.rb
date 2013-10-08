class Addfieldstovenue < ActiveRecord::Migration
  def change
  	change_table :venues do |t| 
  		t.string "name"
  		t.string "address"
  		t.integer "user_id"
  	end	
  end
end
