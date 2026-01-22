class CreateUsersRolesJoinTable < ActiveRecord::Migration[7.2]
  def change
    create_table :users_roles, id: false do |t|
      t.references :user, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
    end

    add_index :users_roles, [:user_id, :role_id], unique: true
  end
end
