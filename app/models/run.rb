class Run < ActiveRecord::Base
  belongs_to :rhcbranch
  belongs_to :brokertype
  has_many :rundockerservers
  has_many :runlogservers
  accepts_nested_attributes_for :rundockerservers, :runlogservers
end
