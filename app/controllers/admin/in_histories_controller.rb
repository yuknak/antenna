class Admin::InHistoriesController < Admin::Base
  before_action :set_in_history, only: [:show, :edit, :update, :destroy]

  # GET /in_histories
  # GET /in_histories.json
  def index
    @in_histories = InHistory.order('rec_time desc').page(params[:page]).per(20)
  end

  # GET /in_histories/1
  # GET /in_histories/1.json
  def show
  end

  # GET /in_histories/new
  def new
    @in_history = InHistory.new
  end

  # GET /in_histories/1/edit
  def edit
  end

  # POST /in_histories
  # POST /in_histories.json
  def create
    @in_history = InHistory.new(in_history_params)

    respond_to do |format|
      if @in_history.save
        format.html { redirect_to admin_in_history_path(@in_history), notice: 'In history was successfully created.' }
        format.json { render :show, status: :created, location: @in_history }
      else
        format.html { render :new }
        format.json { render json: @in_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /in_histories/1
  # PATCH/PUT /in_histories/1.json
  def update
    respond_to do |format|
      if @in_history.update(in_history_params)
        format.html { redirect_to admin_in_history_path(@in_history), notice: 'In history was successfully updated.' }
        format.json { render :show, status: :ok, location: @in_history }
      else
        format.html { render :edit }
        format.json { render json: @in_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /in_histories/1
  # DELETE /in_histories/1.json
  def destroy
    @in_history.destroy
    respond_to do |format|
      format.html { redirect_to admin_in_histories_url, notice: 'In history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_in_history
      @in_history = InHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def in_history_params
      params.require(:in_history).permit(:rec_time, :site_id, :referer, :ip, :chkd, :request_line)
    end
end
