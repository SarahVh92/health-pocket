class RenameStartDateToDate < ActiveRecord::Migration[7.0]
  def change
    rename_column :appointments, :start_date, :date
  end
end
