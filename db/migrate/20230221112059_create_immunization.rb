class CreateImmunization < ActiveRecord::Migration[7.0]
  def change
    create_table :immunizations do |t|
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
