class CreateCarrierwaveDocuments < ActiveRecord::Migration
  def change
    create_table :carrierwave_documents do |t|
      t.string :attachment
      t.string :attachment_scan_results
    end
  end
end
