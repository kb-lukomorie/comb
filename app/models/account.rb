class Account < ActiveRecord::Base
  attr_accessible :last_updated, :updated_categories, :shop, :token, :insales_id
  serialize :updated_categories
  validates_presence_of :insales_id
  validates_presence_of :insales_subdomain
  validates_presence_of :password
end
