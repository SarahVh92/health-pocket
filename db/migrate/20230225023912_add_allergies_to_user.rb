class AddAllergiesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :allergies, :string
  end
end
