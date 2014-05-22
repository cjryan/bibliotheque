class Brokertype < ActiveRecord::Base
  has_many :runbrokers 
  has_many :runs, through: :runbrokers 
end
