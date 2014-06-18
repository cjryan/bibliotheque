class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :update, :destroy]

  # GET /runs
  # GET /runs.json
  def index
    @runs = Run.all
  end

  # GET /runs/1
  # GET /runs/1.json
  def show
  end

  # GET /runs/new
  def new
    @run = Run.new
    # Now let's add at least one dockerserver
    @run.rundockerservers.build
  end

  # GET /runs/1/edit
  def edit
  end

  # POST /
  # if tableruns.json
  def create
    #encrypt the TCMS password before it gets saved to the DB, but first save it to pass it to the docker container
    #clone the run_params because they are immutable
    params = run_params.clone
    tcms_pass_plaintxt = params[:tcms_password]
    params[:tcms_password] = BCrypt::Password.create(params[:tcms_password])
    # By default run is running :)
    params["status_id"] = 3
    @run = Run.new(params)
    respond_to do |format|
      if @run.save
        @docker_kickstart = DockerKickstartsController.new(@run, params["rundockerservers_attributes"], tcms_pass_plaintxt)
        number_of_containers = @docker_kickstart.docker_kickstart
        set_run_status(@run[:id], number_of_containers)
        format.html { redirect_to @run, notice: 'Run was successfully created.' }
        format.json { render :show, status: :created, location: @run }
      else
        format.html { render :new }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /runs/1
  # PATCH/PUT /runs/1.json
  def update
    respond_to do |format|
      if @run.update(run_params)
        format.html { redirect_to @run, notice: 'Run was successfully updated.' }
        format.json { render :show, status: :ok, location: @run }
      else
        format.html { render :edit }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /runs/1
  # DELETE /runs/1.json
  def destroy
    @run.destroy
    FileUtils.rm_rf(File.join(ENV['OPENSHIFT_DATA_DIR'], 'log_repository', @run[:id].to_s))
    respond_to do |format|
      format.html { redirect_to runs_url, notice: 'Run was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_run_status(run_id, global_counter)
    Thread.new do
      # Wait for logs to arrive to update the run's status
      finished = false
      while not finished do
        console_logs = Dir.glob(File.join(ENV['OPENSHIFT_DATA_DIR'], 'log_repository', run_id.to_s, "docker_output*"))
        if console_logs.size < global_counter
          # There should be as many output files as many containers we had
          sleep 10
        else
          # we need to make sure, the last file was successfully written to
          sleep 20
          # Do action
          fcont = []
          console_logs.each do |filename|
            fcont << File.read(filename)
          end
          global_exitcode = 0
          fcont.each do |contents|
            result = fcont[0].match /exitcode:\s(\d+)/
            global_exitcode += result.captures[0].to_i
          end
          if global_exitcode > 0
            runstatus = 2 # Failed
          else
            runstatus = 1 # Passed
          end
          Run.find_by(:id => run_id).update(status_id: runstatus)
          finished = true
        end
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = Run.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def run_params
      params.require(:run).permit(:broker, :testrun, :caseruns, :accounts, :maxgears, :tcms_user, :tcms_password, :rhcbranch_id, :brokertype_id, :accounts_per_job, :debug, :rundockerservers_attributes => [:run_id, :dockerserver_id, :image_id, :jobcount])
    end
end
