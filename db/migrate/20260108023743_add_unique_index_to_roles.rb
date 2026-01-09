class AddUniqueIndexToRoles < ActiveRecord::Migration[7.0]
  def change
    remove_index :roles, name: "index_roles_on_name_and_resource_type_and_resource_id", if_exists: true

    add_index :roles,
              [:name, :resource_type, :resource_id],
              unique: true,
              name: "index_roles_on_name_and_resource_type_and_resource_id"
  end
end
