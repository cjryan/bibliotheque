class Run < ActiveRecord::Base
  class ValidateCaserunTestruns < ActiveModel::Validator
    def validate(record)
      if !record.testrun.blank? and !record.caseruns.blank?
        record.errors[:name] << "You can not specify both testrun_id and caserun_ids"
      elsif record.testrun.blank? and record.caseruns.blank?
        record.errors[:name] << "You should provide either testrun_id or caserun_ids"
      end
    end
  end

  class ValidateEnterpriseAccounts < ActiveModel::Validator
    def validate(record)
      brokertype = Brokertype.find_by(:id => record.brokertype_id).name
      if brokertype != 'devenv'
        if not record.accounts.match /[\w\d\_\.\+]+\@[\w\d\_\.]+\:\S+\:\w+/
          record.errors[:name] << "You should provide coma-separated list of accounts in the format: username@example.com:<password>:<gear_profile>"
        end
        accounts = record.accounts.gsub!(",", "").split
        total_jobcount = 0
        record.rundockerservers.each do |server|
          total_jobcount += server.jobcount
        end
        if accounts.size < total_jobcount * record.accounts_per_job
          record.errors[:name] << "You did not provide enough openshift accounts. Number of accounts should be accounts_per_job * total number of jobs"
        end
      end
    end
  end
  belongs_to :rhcbranch
  belongs_to :brokertype
  belongs_to :status
  has_many :rundockerservers
#  has_many :runlogservers
#  validates :accounts, format: { with: /[\w\d\_\.\+]+\@[\w\d\_\.]+\:\S+\:\w+/, message: "should have the following format: user@domain.com:password:small,"}
  validates :broker, :maxgears, :tcms_user, :tcms_password, :accounts_per_job, :rhcbranch_id, :brokertype_id, presence: true
  validates_with ValidateCaserunTestruns
  validates_with ValidateEnterpriseAccounts
  accepts_nested_attributes_for :rundockerservers
end
