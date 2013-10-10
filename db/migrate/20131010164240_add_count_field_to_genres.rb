class AddCountFieldToGenres < ActiveRecord::Migration
  def change
    add_column :genres, :count, :integer
  end
end
