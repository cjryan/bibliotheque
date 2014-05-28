class Logserver < ActiveRecord::Base
  validates :hostname, :username, presence: true
  has_many :runs
end
