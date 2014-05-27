class Logserver < ActiveRecord::Base
  class ValidateIPHostname < ActiveModel::Validator
    def validate(record)
      if record.ip == "" and record.hostname == ""
        record.errors[:name] << "You should provide either hostname or ip"
      end
    end
  end
  has_many :runs
end
