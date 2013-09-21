class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
    	t.boolean :liked, default: false
    	t.references :user
    	t.references :song

      t.timestamps
    end
  end
end
