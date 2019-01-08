class Admin::OutHistoriesController < Admin::Base
  before_action :set_out_history, only: [:show, :edit, :update, :destroy]

  # GET /out_histories
  # GET /out_histories.json
  def index
    @out_histories = OutHistory.order('rec_time desc').page(params[:page]).per(20)
  end

  # GET /out_histories/1
  # GET /out_histories/1.json
  def show
  end

  # GET /out_histories/new
  def new
    @out_history = OutHistory.new
  end

  # GET /out_histories/1/edit
  def edit
  end

  # POST /out_histories
  # POST /out_histories.json
  def create
    @out_history = OutHistory.new(out_history_params)

    respond_to do |format|
      if @out_history.save
        format.html { redirect_to admin_out_history_path(@out_history), notice: 'Out history was successfully created.' }
        format.json { render :show, status: :created, location: @out_history }
      else
        format.html { render :new }
        format.json { render json: @out_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /out_histories/1
  # PATCH/PUT /out_histories/1.json
  def update
    respond_to do |format|
      if @out_history.update(out_history_params)
        format.html { redirect_to admin_out_history_path(@out_history), notice: 'Out history was successfully updated.' }
        format.json { render :show, status: :ok, location: @out_history }
      else
        format.html { render :edit }
        format.json { render json: @out_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /out_histories/1
  # DELETE /out_histories/1.json
  def destroy
    @out_history.destroy
    respond_to do |format|
      format.html { redirect_to admin_out_histories_url, notice: 'Out history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_out_history
      @out_history = OutHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def out_history_params
      params.require(:out_history).permit(:rec_time, :site_id, :article_id, :ip, :chkd)
    end
end
