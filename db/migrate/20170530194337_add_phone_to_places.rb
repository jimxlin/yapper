class AddPhoneToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :phone, :string
  end
end
