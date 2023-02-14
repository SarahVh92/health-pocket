class AddQrCodeToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :qr_code, :string
  end
end
