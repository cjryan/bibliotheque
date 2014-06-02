class RunlogserversController < ApplicationController
  before_action :set_runlogserver, only: [:show, :edit, :update, :destroy]

  # GET /runlogservers
  # GET /runlogservers.json
  def index
    @runlogservers = Runlogserver.all
  end

  # GET /runlogservers/1
  # GET /runlogservers/1.json
  def show
  end

  # GET /runlogservers/new
  def new
    @runlogserver = Runlogserver.new
  end

  # GET /runlogservers/1/edit
  def edit
  end

  # POST /runlogservers
  # POST /runlogservers.json
  def create
    @runlogserver = Runlogserver.new(runlogserver_params)

    respond_to do |format|
      if @runlogserver.save
        format.html { redirect_to @runlogserver, notice: 'Runlogserver was successfully created.' }
        format.json { render :show, status: :created, location: @runlogserver }
      else
        format.html { render :new }
        format.json { render json: @runlogserver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /runlogservers/1
  # PATCH/PUT /runlogservers/1.json
  def update
    respond_to do |format|
      if @runlogserver.update(runlogserver_params)
        format.html { redirect_to @runlogserver, notice: 'Runlogserver was successfully updated.' }
        format.json { render :show, status: :ok, location: @runlogserver }
      else
        format.html { render :edit }
        format.json { render json: @runlogserver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /runlogservers/1
  # DELETE /runlogservers/1.json
  def destroy
    @runlogserver.destroy
    respond_to do |format|
      format.html { redirect_to runlogservers_url, notice: 'Runlogserver was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_runlogserver
      @runlogserver = Runlogserver.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def runlogserver_params
      params.require(:runlogserver).permit(:run_id, :logserver_id)
    end
end
