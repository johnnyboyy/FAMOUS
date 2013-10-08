class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :request_type
      t.integer :band_id
      t.string :status
      t.integer :sender
      t.integer :reciever
      t.text :message

      t.timestamps
    end
  end
end
