class AddRegistrationDeadlineToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :registration_deadline, :datetime
  end
end
