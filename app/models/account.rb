class Account < ActiveRecord::Base
  attr_accessible :last_updated, :updated_categories
  serialize :updated_categories
  validates_presence_of :insales_id
  validates_presence_of :insales_subdomain
  validates_presence_of :password
end
