class ChangeColumnNameInCategories < ActiveRecord::Migration
  def change
    rename_column(:categories, :type, :name)
  end
end
