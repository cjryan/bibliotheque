class Run < ActiveRecord::Base
  class ValidateCaserunTestruns < ActiveModel::Validator
    def validate(record)
      if record.testrun_id != "" and record.caserun_ids != ""
        record.errors[:name] << "You can not specify both testrun_id and caserun_ids" 
      elsif record.testrun_id == "" and record.caserun_ids == ""
        record.errors[:name] << "You should provide either testrun_id or caserun_ids"
      end
    end
  end

  has_many :runbrokers
  has_many :brokertypes, through: :runbrokers
  has_many :runbranches
  has_many :rhcbranchs, through: :runbranches
  validates :accounts, format: { with: /[\w\d\_\.\+]+\@[\w\d\_\.]+\:\S+\:\w+/, message: "should have the following format: user@domain.com:password:small,"}
  validates :broker, :job_count, :max_gears, :tcms_user, :tcms_password, :accounts_per_job, :rhcbranch, :brokertype, :image_url, :logserver, presence: true
  validates_with ValidateCaserunTestruns
end


