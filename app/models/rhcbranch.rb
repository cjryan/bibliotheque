class Rhcbranch < ActiveRecord::Base
  has_many :runbranches
  has_many :runs, through: :runbranches
end
