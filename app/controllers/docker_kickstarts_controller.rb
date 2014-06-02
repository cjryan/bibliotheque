require "docker"

class DockerKickstartsController < ApplicationController
  def initialize(run)
    @run = run
  end

  def docker_kickstart
    #Configure the docker parameters to pass through the remote API. These will form a HTTP header.
    #
    #For each docker server provided, create a desired amount of containers
    #based on an image id specified for each particular server
    @run.rundockerservers_attributes.each do |key, value|
      docker_opts = {}
      docker_opts['Env'] = []
      docker_opts['Env'] << "TCMS_USER=#{@run.tcms_user}"
      docker_opts['Env'] << "TCMS_PASSWORD=#{@run.tcms_password}"
      docker_opts['Env'] << "OPENSHIFT_BROKER=#{@run.broker}"
      docker_opts['Env'] << "OPENSHIFT_BROKER_TYPE=#{@run.brokertype}"
      docker_opts['Env'] << "DEBUG=#{@run.debug}"
      docker_opts['Env'] << "OPENSHIFT_ACCOUNTS=#{@run.accounts}"
      docker_opts['Env'] << "TESTRUN_ID=#{@run.testrun}"
      docker_opts['Env'] << "CASERUN_IDS=#{@run.caseruns}"
      docker_opts['Env'] << "DOCKER_RUN_ID=#{@run.id}"
      docker_opts['Image'] = value["image_uuid"]
      docker_opts['Env'] << "LOG_SERVER=#{@run.logserver}"
      docker_opts['Env'] << "LOG_SERVER_USERNAME=#{@run.logserver_username}"
      docker_opts['Cmd'] = ['sh','bin/docker_runner.sh']
      Docker.url = Dockerserver.find_by(:id => value["dockerserver_id"]).url
      containers = []
      value["jobcount"].to_i.times do
        containers << Docker::Container.create(docker_opts)
      end

      #Create and run the new container
      #Capture and display the output of the run.
      threads = []
      containers.each do |container|
        begin
          threads << Thread.new do
            # TODO: implement debug mode to keep track of realtime output
  #          if debug
  #            container.tap(&:start).attach { |stream, chunk| puts "#{stream}: #{chunk}" }
  #          else
  #            container.start
  #          end
            container.start
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
end
