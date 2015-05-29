class VigilionScanUsersPicture < ActiveRecord::Migration
  def change
    add_column :users, :picture_scan_results, :string
  end
end