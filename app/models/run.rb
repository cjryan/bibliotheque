class Run < ActiveRecord::Base
  has_many :runbrokers
  has_many :brokertypes, through: :runbrokers
  has_many :runbranches
  has_many :rhcbranchs, through: :runbranches
  validates :accounts, format: { with: /[\w\d\_\.\+]+\@[\w\d\_\.]+\:\S+\:\w+/, message: "should have the following format: user@domain.com:password:small,"}
  validates :broker, :job_count, :max_gears, :tcms_user, :tcms_password, :accounts_per_job, :rhcbranch, :brokertype, :docker_url, :image_url, presence: true
end

#class ValidateCaserunTestruns < ActiveModel::Validator
#  def validate(caseruns=nil, testrun=nil)
#    if caseruns and testruns
#      caseruns.errors[:name] << "You can not specify both testrun_id and caserun_ids" 
#    elsif not caseruns and not testrun
#      testruns.errors[:name] << "You should provide either testrun_id or caserun_ids"
#      caseruns.errors[:name] << testruns.errors[:name][0]
#    end
#  end
#end
