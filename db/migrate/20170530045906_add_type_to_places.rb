class AddTypeToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :type, :string
  end
end
