class LogserversController < ApplicationController
  before_action :set_logserver, only: [:show, :edit, :update, :destroy]

  # GET /logservers
  # GET /logservers.json
  def index
    @logservers = Logserver.all
  end

  # GET /logservers/1
  # GET /logservers/1.json
  def show
  end

  # GET /logservers/new
  def new
    @logserver = Logserver.new
  end

  # GET /logservers/1/edit
  def edit
  end

  # POST /logservers
  # POST /logservers.json
  def create
    @logserver = Logserver.new(logserver_params)

    respond_to do |format|
      if @logserver.save
        format.html { redirect_to @logserver, notice: 'Logserver was successfully created.' }
        format.json { render :show, status: :created, location: @logserver }
      else
        format.html { render :new }
        format.json { render json: @logserver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logservers/1
  # PATCH/PUT /logservers/1.json
  def update
    respond_to do |format|
      if @logserver.update(logserver_params)
        format.html { redirect_to @logserver, notice: 'Logserver was successfully updated.' }
        format.json { render :show, status: :ok, location: @logserver }
      else
        format.html { render :edit }
        format.json { render json: @logserver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logservers/1
  # DELETE /logservers/1.json
  def destroy
    @logserver.destroy
    respond_to do |format|
      format.html { redirect_to logservers_url, notice: 'Logserver was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_logserver
      @logserver = Logserver.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def logserver_params
      params.require(:logserver).permit(:ip, :hostname)
    end
end
