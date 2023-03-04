class ChangeUsersAllergiesToArray < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :allergies, :string, array: true, default: [], using: "(string_to_array(allergies, ','))"
  end
end
