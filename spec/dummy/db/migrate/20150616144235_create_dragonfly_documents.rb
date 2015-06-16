class CreateDragonflyDocuments < ActiveRecord::Migration
  def change
    create_table :dragonfly_documents do |t|
      t.attachment :attachment_uid
      t.string :attachment_scan_results
    end
  end
end
