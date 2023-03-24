class RemoveStringFromAppointments < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :string, :string
  end
end
