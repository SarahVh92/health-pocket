class CreateDoctorLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :doctor_logs do |t|
      t.string :doctor_name
      t.date :date
      t.string :hospital_name

      t.timestamps
    end
  end
end
