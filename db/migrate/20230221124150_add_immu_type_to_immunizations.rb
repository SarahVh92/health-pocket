class AddImmuTypeToImmunizations < ActiveRecord::Migration[7.0]
  def change
    add_column :immunizations, :immu_type, :string
  end
end
