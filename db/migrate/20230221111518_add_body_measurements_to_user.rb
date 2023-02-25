class AddBodyMeasurementsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :weight, :string
    add_column :users, :height, :string
    add_column :users, :body_fat, :string
    add_column :users, :chest, :string
    add_column :users, :arms, :string
    add_column :users, :legs, :string
  end
end
