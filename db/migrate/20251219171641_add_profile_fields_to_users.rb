class AddProfileFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :age, :integer
    add_column :users, :phone, :string
    add_column :users, :bio, :text
    add_column :users, :location_type, :integer, default: 0
    add_column :users, :gender, :integer
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
  end
end
