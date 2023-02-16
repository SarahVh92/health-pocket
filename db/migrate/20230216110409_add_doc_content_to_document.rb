class AddDocContentToDocument < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :doc_content, :string
  end
end
