require "docker"

class DockerKickstartsController < ApplicationController
  def initialize(run)
    @run = run
  end

  def docker_kickstart
    require "debugger"
    debugger
    #Configure the docker parameters to pass through the remote API. These will form a HTTP header.
    docker_opts = {}
    docker_opts['Env'] = []
    docker_opts['Env'] << "TCMS_USER=#{@run.tcms_user}"
    docker_opts['Env'] << "TCMS_PASSWORD=#{@run.tcms_password}"
    docker_opts['Env'] << "OPENSHIFT_BROKER=#{@run.broker}"
    docker_opts['Env'] << "OPENSHIFT_BROKER_TYPE=#{@run.brokertype}"
    docker_opts['Env'] << "DEBUG=#{@run.debug}"
    docker_opts['Env'] << "OPENSHIFT_ACCOUNTS=#{@run.accounts}"
    docker_opts['Env'] << "TESTRUN_ID=#{@run.testrun_id}"
    docker_opts['Env'] << "CASERUN_IDS=#{@run.caserun_ids}"
    docker_opts['Env'] << "DOCKER_RUN_ID=#{@run.id}"
    docker_opts['Image'] = "#{@run.image_url}"
    docker_opts['Env'] << "LOG_SERVER=#{@run.logserver}"
    docker_opts['Env'] << "LOG_SERVER_USERNAME=#{@run.logserver_username}"

    #An entrypoint can be used for complex commands. Specify the program in entrypoint, and the
    #args in 'Cmd'. 'Cmd' is an array of arguments. It would look like
    #docker_opts['Entrypoint'] = 'ls'
    #docker_opts['cmd'] = ['-la']
    #If you wish to prepend or append lines, consider the following as a "command line",
    #and you must use && to add more commands.
    #docker_opts['Cmd'] = ['sh','bin/docker_runner.sh','features/rest/add_app.feature:123']
    docker_opts['Cmd'] = ['sh','bin/docker_runner.sh']

    Docker.url = @run.docker_url
    containers = []
    containers << Docker::Container.create(docker_opts)

    #Create and run the new container
    #Capture and display the output of the run.
    threads = []
    containers.each do |container|
      begin
        threads << Thread.new do
          container.tap(&:start).attach { |stream, chunk| puts "#{stream}: #{chunk}" }
        end
      rescue Exception => e
        puts e.response
      ensure
        #Once the run is complete, clean up and remove the containers to free up space.
        container.tap(&:stop)
        container.remove
      end
    end
  end
end
