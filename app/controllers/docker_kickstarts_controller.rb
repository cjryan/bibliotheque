require "docker"

class DockerKickstartsController < ApplicationController
  def initialize(run, dockerservers_attributes, tcms_password)
    @run = run
    @dockerservers_attributes = dockerservers_attributes
    @tcms_password = tcms_password
  end

  def random_account
    alphabet = "qwertyuiopasdfghjklzxcvbnm"
    name = ""
    domain = ""
    0.upto(7) do |counter|
      name += alphabet[rand(alphabet.size)]
      domain += alphabet[rand(alphabet.size)]
    end
    return "#{name}@#{domain}.com:redhat:small"
  end

  def sharecases(case_array, no_of_conts)
  # accepts an array of cases and an integer number of containers to launch
  # Returns an array of arrays
    result = []
    # First make as many of internal arrays as many containers we will have
    no_of_conts.downto(1) do |counter|
      result << []
    end

    # Now let's populate them
    counter = 0
    case_array.each do |elem|
      result[counter] << elem
      if counter < no_of_conts - 1
        counter += 1
      else
        counter = 0
      end
    end
    return result
  end
  


  def docker_kickstart
    #Configure the docker parameters to pass through the remote API. These will form a HTTP header.
    #
    #For each docker server provided, create a desired amount of containers
    #based on an image id specified for each particular server
    rhcbranch = Rhcbranch.find_by(:id => @run.rhcbranch_id).name
    brokertype = Brokertype.find_by(:id => @run.brokertype_id).name
#    logserver = Logserver.find_by(:id => @run.logserver_id).hostname
#    logserver_username = Logserver.find_by(:id => @run.logserver_id).username
    if brokertype != 'devenv'
      allaccounts = sharecases(@run.accounts.gsub(",", "").split, @dockerservers_attributes.size)
    end
    global_counter = 0 # count total amount of containers: needed for analyzing exit status of all logs
    dockerserver_index = 0 # count dockerservers: needed for account sharing
    @dockerservers_attributes.each do |key, value|
      docker_opts = {}
      docker_opts['Env'] = []
      if @run.debug == true
        docker_opts['Env'] << "DEBUG=true"
      end
      docker_opts['Env'] << "RHC_BRANCH=#{rhcbranch}"
      docker_opts['Env'] << "TCMS_USER=#{@run.tcms_user}"
      docker_opts['Env'] << "TCMS_PASSWORD=#{@tcms_password}"
      docker_opts['Env'] << "OPENSHIFT_BROKER=#{@run.broker}"
      docker_opts['Env'] << "OPENSHIFT_BROKER_TYPE=#{brokertype}"
#      docker_opts['Env'] << "DEBUG=#{@run.debug}"
      docker_opts['Env'] << "TESTRUN_ID=#{@run.testrun}"
      docker_opts['Env'] << "CASERUN_IDS=#{@run.caseruns}"
      docker_opts['Env'] << "DOCKER_RUN_ID=#{@run.id}"
      docker_opts['Image'] = value["image_id"]
      docker_opts['Env'] << "LOG_SERVER=#{ENV['OPENSHIFT_GEAR_DNS']}"
      docker_opts['Env'] << "LOG_SERVER_USERNAME=#{'OPENSHIFT_APP_UUID'}"

#      docker_opts['Env'] << "LOG_SERVER=#{logserver}"
#      docker_opts['Env'] << "LOG_SERVER_USERNAME=#{logserver_username}"
      docker_opts['Cmd'] = ['sh','bin/docker_runner.sh']
      if brokertype == 'devenv'
        accountarray = []
        1.upto(@run.accounts_per_job * value["jobcount"].to_i) do
          accountarray << random_account 
        end
        accounts = sharecases(accountarray, value["jobcount"].to_i)
      else
        accounts = sharecases(allaccounts[dockerserver_index], value["jobcount"].to_i)
      end
#      docker_opts['Cmd'] = ['/bin/bash']
      Docker.url = Dockerserver.find_by(:id => value["dockerserver_id"]).url
      containers = []
      value["jobcount"].to_i.times do |local_counter|
        docker_opts_specific = docker_opts.clone
        docker_opts_specific['Env'] << "OPENSHIFT_ACCOUNTS=#{accounts[local_counter].join(',')}"
        containers << Docker::Container.create(docker_opts_specific)
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
        global_counter += 1
      end
      dockerserver_index += 1
    end
    return global_counter
  end
end
