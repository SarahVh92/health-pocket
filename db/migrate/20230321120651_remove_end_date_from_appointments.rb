class RemoveEndDateFromAppointments < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :end_date, :datetime
  end
end
