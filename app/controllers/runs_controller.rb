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

  # POST /runs
  # POST /runs.json
  def create
      params = run_params.clone
      params["rhcbranch"] = Rhcbranch.find_by(:id => run_params["rhcbranch_id"]).name
      params["brokertype"] = Brokertype.find_by(:id => run_params["brokertype_id"]).name
      params["logserver"] = Logserver.find_by(:id => run_params["logserver_id"]).hostname
      params["logserver_username"] = Logserver.find_by(:id => run_params["logserver_id"]).username
      @run = Run.new(params)
      @docker_kickstart = DockerKickstartsController.new(@run)
      @docker_kickstart.docker_kickstart


    respond_to do |format|
      if @run.save
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
    respond_to do |format|
      format.html { redirect_to runs_url, notice: 'Run was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = Run.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def run_params
      params.require(:run).permit(:broker, :testrun, :caseruns, :accounts, :maxgears, :tcms_user, :tcms_password, :rhcbranch_id, :brokertype_id, :accounts_per_job, :logserver_id, :rundockerservers_attributes => [:run_id, :dockerserver_id, :image_id, :jobcount])
    end
end
