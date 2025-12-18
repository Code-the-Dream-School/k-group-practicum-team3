class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description
      t.string :city
      t.integer :price
      t.datetime :starts_at, null: false
      t.datetime :ends_at
      t.integer :category, null: false
      t.integer :age_min
      t.integer :age_max
      t.integer :allowed_gender,  null: false, default: 0
      t.references :organizer, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
