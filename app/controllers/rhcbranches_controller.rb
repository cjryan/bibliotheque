class RhcbranchesController < ApplicationController
  before_action :set_rhcbranch, only: [:show, :edit, :update, :destroy]

  # GET /rhcbranches
  # GET /rhcbranches.json
  def index
    @rhcbranches = Rhcbranch.all
  end

  # GET /rhcbranches/1
  # GET /rhcbranches/1.json
  def show
  end

  # GET /rhcbranches/new
  def new
    @rhcbranch = Rhcbranch.new
  end

  # GET /rhcbranches/1/edit
  def edit
  end

  # POST /rhcbranches
  # POST /rhcbranches.json
  def create
    @rhcbranch = Rhcbranch.new(rhcbranch_params)

    respond_to do |format|
      if @rhcbranch.save
        format.html { redirect_to @rhcbranch, notice: 'Rhcbranch was successfully created.' }
        format.json { render :show, status: :created, location: @rhcbranch }
      else
        format.html { render :new }
        format.json { render json: @rhcbranch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rhcbranches/1
  # PATCH/PUT /rhcbranches/1.json
  def update
    respond_to do |format|
      if @rhcbranch.update(rhcbranch_params)
        format.html { redirect_to @rhcbranch, notice: 'Rhcbranch was successfully updated.' }
        format.json { render :show, status: :ok, location: @rhcbranch }
      else
        format.html { render :edit }
        format.json { render json: @rhcbranch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rhcbranches/1
  # DELETE /rhcbranches/1.json
  def destroy
    @rhcbranch.destroy
    respond_to do |format|
      format.html { redirect_to rhcbranches_url, notice: 'Rhcbranch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rhcbranch
      @rhcbranch = Rhcbranch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rhcbranch_params
      params.require(:rhcbranch).permit(:branch)
    end
end
