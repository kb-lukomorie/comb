class AddUpdatedCategoriesToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :updated_categories, :text
  end
end
