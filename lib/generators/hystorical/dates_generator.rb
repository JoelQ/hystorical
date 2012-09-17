module Hystorical
  class DatesGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)
    argument :model, type: :string

    def self.next_migration_number(path)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end

    def hystorical_migration
      migration_template 'migration.rb', File.join('db/migrate', "add_start_date_end_date_to_#{model.tableize}.rb")
    end
  end
end
