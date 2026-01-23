class AddLocationTypeToUsers < ActiveRecord::Migration[7.2]
  def change
    return if column_exists?(:users, :location_type)

    add_column :users, :location_type, :integer, default: 0
  end
end
