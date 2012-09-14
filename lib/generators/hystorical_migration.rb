class HystoricalMigration < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)
  argument :model, type: :string

  def hystorical_migration
    migration_template 'migration.rb', File.join('db/migrate', "add_start_date_end_date_to#{model.tableize}.rb")
  end
end
