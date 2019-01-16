class Admin::DailyWeightsController < Admin::Base
  before_action :set_daily_weight, only: [:show, :edit, :update, :destroy]

  # GET /daily_weights
  # GET /daily_weights.json
  def index
    @daily_weights = DailyWeight.order('weight_date desc, weight desc').page(params[:page]).per(20)
  end

  # GET /daily_weights/1
  # GET /daily_weights/1.json
  def show
  end

  # GET /daily_weights/new
  def new
    @daily_weight = DailyWeight.new
  end

  # GET /daily_weights/1/edit
  def edit
  end

  # POST /daily_weights
  # POST /daily_weights.json
  def create
    @daily_weight = DailyWeight.new(daily_weight_params)

    respond_to do |format|
      if @daily_weight.save
        format.html { redirect_to admin_daily_weight_path(@daily_weight), notice: 'Daily weight was successfully created.' }
        format.json { render :show, status: :created, location: @daily_weight }
      else
        format.html { render :new }
        format.json { render json: @daily_weight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_weights/1
  # PATCH/PUT /daily_weights/1.json
  def update
    respond_to do |format|
      if @daily_weight.update(daily_weight_params)
        format.html { redirect_to admin_daily_weight_path(@daily_weight), notice: 'Daily weight was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_weight }
      else
        format.html { render :edit }
        format.json { render json: @daily_weight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_weights/1
  # DELETE /daily_weights/1.json
  def destroy
    @daily_weight.destroy
    respond_to do |format|
      format.html { redirect_to admin_daily_weights_url, notice: 'Daily weight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_weight
      @daily_weight = DailyWeight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_weight_params
      params.require(:daily_weight).permit(:weight_date, :site_id, :weight)
    end
end
