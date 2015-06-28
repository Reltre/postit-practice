class ChangeAdminColumnToRole < ActiveRecord::Migration
  def change
    rename_column :users, :is_admin, :role
    change_column :users, :role, :string
  end
end
