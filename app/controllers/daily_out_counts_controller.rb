class DailyOutCountsController < ApplicationController
  before_action :set_daily_out_count, only: [:show, :edit, :update, :destroy]

  # GET /daily_out_counts
  # GET /daily_out_counts.json
  def index
    @daily_out_counts = DailyOutCount.page(params[:page]).per(20)
  end

  # GET /daily_out_counts/1
  # GET /daily_out_counts/1.json
  def show
  end

  # GET /daily_out_counts/new
  def new
    @daily_out_count = DailyOutCount.new
  end

  # GET /daily_out_counts/1/edit
  def edit
  end

  # POST /daily_out_counts
  # POST /daily_out_counts.json
  def create
    @daily_out_count = DailyOutCount.new(daily_out_count_params)

    respond_to do |format|
      if @daily_out_count.save
        format.html { redirect_to @daily_out_count, notice: 'Daily out count was successfully created.' }
        format.json { render :show, status: :created, location: @daily_out_count }
      else
        format.html { render :new }
        format.json { render json: @daily_out_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_out_counts/1
  # PATCH/PUT /daily_out_counts/1.json
  def update
    respond_to do |format|
      if @daily_out_count.update(daily_out_count_params)
        format.html { redirect_to @daily_out_count, notice: 'Daily out count was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_out_count }
      else
        format.html { render :edit }
        format.json { render json: @daily_out_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_out_counts/1
  # DELETE /daily_out_counts/1.json
  def destroy
    @daily_out_count.destroy
    respond_to do |format|
      format.html { redirect_to daily_out_counts_url, notice: 'Daily out count was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_out_count
      @daily_out_count = DailyOutCount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_out_count_params
      params.require(:daily_out_count).permit(:count_date, :site_id, :count)
    end
end
