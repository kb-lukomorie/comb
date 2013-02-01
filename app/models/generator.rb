# == Schema Information
#
# Table name: generators
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  words      :text
#  created_at :datetime
#  updated_at :datetime
#

class Generator < ActiveRecord::Base
  attr_accessible :name, :words
  serialize :words
end
