class Generator < ActiveRecord::Base
  attr_accessible :name, :words
  serialize :words
end
