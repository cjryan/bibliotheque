require "docker"

class DockerKickstartsController < ApplicationController
  def initialize(run, dockerservers_attributes)
    @run = run
    @dockerservers_attributes = dockerservers_attributes
  end

  def docker_kickstart
    #Configure the docker parameters to pass through the remote API. These will form a HTTP header.
    #
    #For each docker server provided, create a desired amount of containers
    #based on an image id specified for each particular server
    @dockerservers_attributes.each do |key, value|
      rhcbranch = Rhcbranch.find_by(:id => @run.rhcbranch_id).name
      brokertype = Brokertype.find_by(:id => @run.brokertype_id).name
      logserver = Logserver.find_by(:id => @run.logserver_id).hostname
      logserver_username = Logserver.find_by(:id => @run.logserver_id).username
     
      docker_opts = {}
      docker_opts['Env'] = []
      docker_opts['Env'] << "RHC_BRANCH=#{rhcbranch}"
      docker_opts['Env'] << "TCMS_USER=#{@run.tcms_user}"
      docker_opts['Env'] << "TCMS_PASSWORD=#{@run.tcms_password}"
      docker_opts['Env'] << "OPENSHIFT_BROKER=#{@run.broker}"
      docker_opts['Env'] << "OPENSHIFT_BROKER_TYPE=#{brokertype}"
#      docker_opts['Env'] << "DEBUG=#{@run.debug}"
      docker_opts['Env'] << "OPENSHIFT_ACCOUNTS=#{@run.accounts}"
      docker_opts['Env'] << "TESTRUN_ID=#{@run.testrun}"
      docker_opts['Env'] << "CASERUN_IDS=#{@run.caseruns}"
      docker_opts['Env'] << "DOCKER_RUN_ID=#{@run.id}"
      docker_opts['Image'] = value["image_id"]
      docker_opts['Env'] << "LOG_SERVER=#{logserver}"
      docker_opts['Env'] << "LOG_SERVER_USERNAME=#{logserver_username}"
      docker_opts['Cmd'] = ['sh','bin/docker_runner.sh']
#      docker_opts['Cmd'] = ['/bin/bash']
      Docker.url = Dockerserver.find_by(:id => value["dockerserver_id"]).url
      containers = []
      value["jobcount"].to_i.times do
        containers << Docker::Container.create(docker_opts)
      end

      #Create and run the new container
      #Capture and display the output of the run.
      containers.each do |container|
        fork do
          begin
            # TODO: implement debug mode to keep track of realtime output
            container.start
            # Now give it maximum 6 hours to run
            container.wait(21600) 
          rescue Exception => e
            puts e.message
          ensure
          #Once the run is complete, clean up and remove the containers to free up space.
            container.tap(&:stop)
            container.remove
          end
        end
      end
    end
  end
end
