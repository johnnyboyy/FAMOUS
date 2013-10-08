class Addimagestovenue < ActiveRecord::Migration
  def change
  		add_attachment :venues, :image 	
  end
end
