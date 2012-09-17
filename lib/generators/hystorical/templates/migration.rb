class AddStartDateEndDateTo<%= model.classify %> < ActiveRecord::Migration
  def change
    add_column :<%= model.tableize %>, :start_date, :date
    add_column :<%= model.tableize %>, :end_date, :date
  end
end
