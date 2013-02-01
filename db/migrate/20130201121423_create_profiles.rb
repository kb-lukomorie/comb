class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :city
      t.string :shop_name
      t.text :shop_description
      t.boolean :delivery_in_russia
      t.boolean :free_delivery
      t.boolean :self_delivery
      t.string :special_url
      t.boolean :card_payments
      t.boolean :cashless
      t.belongs_to :account

      t.timestamps
    end
    add_index :profiles, :account_id
  end
end
