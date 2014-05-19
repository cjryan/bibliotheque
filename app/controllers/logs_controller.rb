class LogsController < ApplicationController
  def index
    data_dir = ENV[OPENSHIFT_DATA_DIR]
    @log_list = Dir.entries(data_dir)
  end
end
