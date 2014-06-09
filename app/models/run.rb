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
  belongs_to :rhcbranch
  belongs_to :brokertype
  has_many :rundockerservers
  has_many :runlogservers
  validates :accounts, format: { with: /[\w\d\_\.\+]+\@[\w\d\_\.]+\:\S+\:\w+/, message: "should have the following format: user@domain.com:password:small,"}
  validates :broker, :maxgears, :tcms_user, :tcms_password, :accounts_per_job, :rhcbranch_id, :brokertype_id, :logserver_id, presence: true
  validates_with ValidateCaserunTestruns


  accepts_nested_attributes_for :rundockerservers
end
