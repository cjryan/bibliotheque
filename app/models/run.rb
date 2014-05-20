class Run < ActiveRecord::Base
  has_many :runbrokers
  has_many :brokertypes, through: :runbrokers
  has_many :runbranches
  has_many :rhcbranchs, through: :runbranches
end
