# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  city               :string(255)
#  shop_name          :string(255)
#  shop_description   :text
#  delivery_in_russia :boolean
#  free_delivery      :boolean
#  self_delivery      :boolean
#  special_url        :string(255)
#  card_payments      :boolean
#  cashless           :boolean
#  account_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Profile < ActiveRecord::Base
  belongs_to :account
end
