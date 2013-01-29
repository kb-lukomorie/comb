class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :city
      t.string :shop_name
      t.string :shop_description
      t.boolean :delivery_to_russia
      t.boolean :free_delivery
      t.boolean :self_delivery
      t.string :special_url
      t.boolean :card_payments
      t.boolean :cashless
      t.references :account

      t.timestamps
    end
    add_index :profiles, :account_id
  end
end
