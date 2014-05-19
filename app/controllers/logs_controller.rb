class LogsController < ApplicationController
  def index
    @logs = []
    data_dir = ENV['OPENSHIFT_DATA_DIR']
    log_dir = data_dir + "/log_repository"
    dir_listing = Dir.entries(log_dir)
    dir_listing.each do |folder|
      #ignore current and previous dirs
      next if folder == "."
      next if folder == ".."
      @logs << folder
      return @logs
    end
  end
end
