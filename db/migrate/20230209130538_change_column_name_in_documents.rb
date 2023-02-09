class ChangeColumnNameInDocuments < ActiveRecord::Migration[7.0]
  def change
    rename_column :documents, :type, :doc_type
  end
end
