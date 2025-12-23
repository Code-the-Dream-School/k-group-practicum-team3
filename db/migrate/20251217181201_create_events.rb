class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description

      t.string :location
      t.string :city
      t.string :state

      t.datetime :starts_at, null: false
      t.datetime :ends_at

      t.integer :category, null: false
      t.integer :price

      t.integer :min_age
      t.integer :max_age
      t.integer :allowed_gender,  null: false, default: 0

      t.integer :rsvp, null: false, default: 0
      t.boolean :accessible, default: false
      t.integer :max_capacity

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
