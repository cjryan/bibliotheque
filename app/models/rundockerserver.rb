class Rundockerserver < ActiveRecord::Base
  belongs_to :run
  belongs_to :dockerserver
  belongs_to :image
#  validates :run_id, :dockerserver_id, :image_id, presence: true
end
