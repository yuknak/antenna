class ArticleOutCountsController < ApplicationController
  before_action :set_article_out_count, only: [:show, :edit, :update, :destroy]

  # GET /article_out_counts
  # GET /article_out_counts.json
  def index
    @article_out_counts = ArticleOutCount.all
  end

  # GET /article_out_counts/1
  # GET /article_out_counts/1.json
  def show
  end

  # GET /article_out_counts/new
  def new
    @article_out_count = ArticleOutCount.new
  end

  # GET /article_out_counts/1/edit
  def edit
  end

  # POST /article_out_counts
  # POST /article_out_counts.json
  def create
    @article_out_count = ArticleOutCount.new(article_out_count_params)

    respond_to do |format|
      if @article_out_count.save
        format.html { redirect_to @article_out_count, notice: 'Article out count was successfully created.' }
        format.json { render :show, status: :created, location: @article_out_count }
      else
        format.html { render :new }
        format.json { render json: @article_out_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_out_counts/1
  # PATCH/PUT /article_out_counts/1.json
  def update
    respond_to do |format|
      if @article_out_count.update(article_out_count_params)
        format.html { redirect_to @article_out_count, notice: 'Article out count was successfully updated.' }
        format.json { render :show, status: :ok, location: @article_out_count }
      else
        format.html { render :edit }
        format.json { render json: @article_out_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_out_counts/1
  # DELETE /article_out_counts/1.json
  def destroy
    @article_out_count.destroy
    respond_to do |format|
      format.html { redirect_to article_out_counts_url, notice: 'Article out count was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_out_count
      @article_out_count = ArticleOutCount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_out_count_params
      params.require(:article_out_count).permit(:last_time, :article_id, :count)
    end
end
