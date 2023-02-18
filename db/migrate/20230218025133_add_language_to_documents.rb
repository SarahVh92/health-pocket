class AddLanguageToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :language, :string
  end
end
