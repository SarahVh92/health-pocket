class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :type
      t.string :country
      t.string :doctor_name
      t.text :comment
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
