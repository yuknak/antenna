class Admin::DailyInCountsController < Admin::Base
  before_action :set_daily_in_count, only: [:show, :edit, :update, :destroy]

  # GET /daily_in_counts
  # GET /daily_in_counts.json
  def index
    @daily_in_counts = DailyInCount.page(params[:page]).per(20)
  end

  # GET /daily_in_counts/1
  # GET /daily_in_counts/1.json
  def show
  end

  # GET /daily_in_counts/new
  def new
    @daily_in_count = DailyInCount.new
  end

  # GET /daily_in_counts/1/edit
  def edit
  end

  # POST /daily_in_counts
  # POST /daily_in_counts.json
  def create
    @daily_in_count = DailyInCount.new(daily_in_count_params)

    respond_to do |format|
      if @daily_in_count.save
        format.html { redirect_to admin_daily_in_count_path(@daily_in_count), notice: 'Daily in count was successfully created.' }
        format.json { render :show, status: :created, location: @daily_in_count }
      else
        format.html { render :new }
        format.json { render json: @daily_in_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_in_counts/1
  # PATCH/PUT /daily_in_counts/1.json
  def update
    respond_to do |format|
      if @daily_in_count.update(daily_in_count_params)
        format.html { redirect_to admin_daily_in_count_path(@daily_in_count), notice: 'Daily in count was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_in_count }
      else
        format.html { render :edit }
        format.json { render json: @daily_in_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_in_counts/1
  # DELETE /daily_in_counts/1.json
  def destroy
    @daily_in_count.destroy
    respond_to do |format|
      format.html { redirect_to admin_daily_in_counts_url, notice: 'Daily in count was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_in_count
      @daily_in_count = DailyInCount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_in_count_params
      params.require(:daily_in_count).permit(:count_date, :site_id, :count)
    end
end
