# == Schema Information
#
# Table name: accounts
#
#  id                 :integer          not null, primary key
#  insales_subdomain  :text             not null
#  password           :text             not null
#  insales_id         :integer          not null
#  created_at         :datetime
#  updated_at         :datetime
#  last_updated       :datetime
#  updated_categories :text
#  fail_products      :text
#

class Account < ActiveRecord::Base
  attr_accessible :last_updated, :updated_categories, :fail_products, :fail_subcategories, :insales_subdomain,
                  :password, :insales_id
  serialize :updated_categories
  serialize :fail_products
  serialize :fail_subcategories
  validates_presence_of :insales_id
  validates_presence_of :insales_subdomain
  validates_presence_of :password

  has_one :profile, dependent: :destroy
end
