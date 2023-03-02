class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :string
      t.datetime :start_date
      t.datetime :end_date
      t.integer :user_id
      t.string :description
      t.text :address

      t.timestamps
    end
  end
end
