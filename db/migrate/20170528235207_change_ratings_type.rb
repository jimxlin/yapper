class ChangeRatingsType < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :rating
    add_column :comments, :rating, :integer
  end
end
