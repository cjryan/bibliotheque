class Runlogserver < ActiveRecord::Base
  belongs_to :run
  belongs_to :logserver
end
