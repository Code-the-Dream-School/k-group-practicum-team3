class CreateRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :resource_type
      t.bigint :resource_id

      t.timestamps
    end

    add_index :roles, [:name, :resource_type, :resource_id], name: "index_roles_on_name_and_resource_type_and_resource_id"
    add_index :roles, [:resource_type, :resource_id], name: "index_roles_on_resource"
  end
end
