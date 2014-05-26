class LogsController < ApplicationController
  def display
    file = Dir.glob(File.join('/home/ofayans/work/trololo/bibliotheque/app/views/static', 'log_repository', params["id"], "logs", "*"))[0]
    send_file(file, :disposition => 'inline', :type => "html")
  end
end
