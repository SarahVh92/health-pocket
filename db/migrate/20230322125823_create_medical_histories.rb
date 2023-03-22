class CreateMedicalHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_histories do |t|
      t.string :disease
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
