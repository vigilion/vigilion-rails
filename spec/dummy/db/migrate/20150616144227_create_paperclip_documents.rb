class CreatePaperclipDocuments < ActiveRecord::Migration
  def change
    create_table :paperclip_documents do |t|
      t.attachment :attachment
      t.string :attachment_scan_results
    end
  end
end
