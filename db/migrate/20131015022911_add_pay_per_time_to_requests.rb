class AddPayPerTimeToRequests < ActiveRecord::Migration
  def change
    change_table :requests do |t|
      t.integer :pay
      t.string :per
      t.datetime :showtime

    end
  end
end
