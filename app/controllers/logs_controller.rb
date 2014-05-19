class LogsController < ApplicationController
  def index
    data_dir = ENV['OPENSHIFT_DATA_DIR']
    log_dir = data_dir + "/log_repository"
    @log_list = Dir.entries(log_dir).each do |folder|
      #ignore current and previous dirs
      next if folder == '.'
      next if folder == '..'
    end
  end
end
