class AddTimestampsToTables < ActiveRecord::Migration
  def change
    tables = [:users,:posts,:comments,:categories]
    tables.each do |table|
      add_column table, :created_at, :datetime
      add_column table, :updated_at, :datetime
    end
  end
end
