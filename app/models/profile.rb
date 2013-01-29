class Profile < ActiveRecord::Base
  belongs_to :account
  attr_accessible :card_payments, :cashless, :city, :delivery_to_russia, :free_delivery, :self_delivery,
                  :shop_description, :shop_name, :special_url
end
