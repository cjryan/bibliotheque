class RunsController < ApplicationController
  before_action :set_run, only: [:show, :destroy]

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
  end

  # GET /runs/1/edit
  def edit
  end

  # POST /runs
  # POST /runs.json
  def create
    params = run_params.clone
    params["docker_url"] = Dockerserver.find_by(:id => run_params["docker_url"]).url
    params["rhcbranch"] = Rhcbranch.find_by(:id => run_params["rhcbranch"]).branch
    params["brokertype"] = Brokertype.find_by(:id => run_params["brokertype"]).brokertype
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
    @images = ["1", "2"]
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
      params.require(:run).permit(:broker, :testrun_id, :caserun_ids, :rhcbranch, :brokertype, :accounts, :job_count, :max_gears, :debug, :tcms_user, :tcms_password, :accounts_per_job, :docker_url, :image_url)
    end
end
