class CreateAgnosticDocuments < ActiveRecord::Migration
  def change
    create_table :agnostic_documents do |t|
      t.string :attachment_url
      t.string :attachment_scan_results
    end
  end
end
