class FixTypeNameInPlaces < ActiveRecord::Migration[5.0]
  def change
    rename_column :places, :type, :place_type
  end
end
