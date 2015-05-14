class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :type
      t.integer :post_id
    end

    add_index :categories, :post_id
  end
end
