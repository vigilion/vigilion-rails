require 'rails/generators'
require 'rails/generators/migration'

class Vigilion::ScanGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)
  argument :model_name, :type => :string
  argument :attribute_name, :type => :string

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_model_file
    @table_name = model_name.tableize
    @column_name = "#{attribute_name}_scan_results"
    @migration_name = "vigilion_scan_#{@table_name}_#{attribute_name}"
    migration_template "add_scan_results_columns.rb.erb", "db/migrate/#{@migration_name}.rb"
  end
end
