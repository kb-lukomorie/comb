class AddLastUpdatedToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :last_updated, :datetime
  end
end
