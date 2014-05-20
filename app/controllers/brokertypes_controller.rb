class BrokertypesController < ApplicationController
  before_action :set_brokertype, only: [:show, :edit, :update, :destroy]

  # GET /brokertypes
  # GET /brokertypes.json
  def index
    @brokertypes = Brokertype.all
  end

  # GET /brokertypes/1
  # GET /brokertypes/1.json
  def show
  end

  # GET /brokertypes/new
  def new
    @brokertype = Brokertype.new
  end

  # GET /brokertypes/1/edit
  def edit
  end

  # POST /brokertypes
  # POST /brokertypes.json
  def create
    @brokertype = Brokertype.new(brokertype_params)

    respond_to do |format|
      if @brokertype.save
        format.html { redirect_to @brokertype, notice: 'Brokertype was successfully created.' }
        format.json { render :show, status: :created, location: @brokertype }
      else
        format.html { render :new }
        format.json { render json: @brokertype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brokertypes/1
  # PATCH/PUT /brokertypes/1.json
  def update
    respond_to do |format|
      if @brokertype.update(brokertype_params)
        format.html { redirect_to @brokertype, notice: 'Brokertype was successfully updated.' }
        format.json { render :show, status: :ok, location: @brokertype }
      else
        format.html { render :edit }
        format.json { render json: @brokertype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brokertypes/1
  # DELETE /brokertypes/1.json
  def destroy
    @brokertype.destroy
    respond_to do |format|
      format.html { redirect_to brokertypes_url, notice: 'Brokertype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brokertype
      @brokertype = Brokertype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brokertype_params
      params.require(:brokertype).permit(:brokertype)
    end
end
