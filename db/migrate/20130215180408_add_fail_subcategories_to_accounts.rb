class AddFailSubcategoriesToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :fail_subcategories, :text
  end
end
