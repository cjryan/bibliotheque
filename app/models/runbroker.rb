class Runbroker < ActiveRecord::Base
  belongs_to :run
  belongs_to :brokertype
end
