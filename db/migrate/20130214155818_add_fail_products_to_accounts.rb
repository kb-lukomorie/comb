class AddFailProductsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :fail_products, :text
  end
end
