class Runbranch < ActiveRecord::Base
  belongs_to :run
  belongs_to :rhcbranch
end
