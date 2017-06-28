class ChaptersController < ApplicationController
  before_action :set_chapter, only: [
    :show, :edit, :update, :destroy, :raise_order, :lower_order
  ]

  # GET /chapters
  # GET /chapters.json
  def index
    @chapters = Chapter.order(:order_id).all
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
  end

  # GET /chapters/new
  def new
    @chapter = Chapter.new
  end

  # GET /chapters/1/edit
  def edit
  end

  # POST /chapters
  # POST /chapters.json
  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.order_id = Chapter.count + 1

    respond_to do |format|
      if @chapter.save
        format.html { redirect_to @chapter, notice: 'Chapter was successfully created.' }
        format.json { render :show, status: :created, location: @chapter }
      else
        format.html { render :new }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1
  # PATCH/PUT /chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to @chapter, notice: 'Chapter was successfully updated.' }
        format.json { render :show, status: :ok, location: @chapter }
      else
        format.html { render :edit }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1/raise_order
  # PATCH/PUT /chapters/1/raise_order.json
  def raise_order
    respond_to do |format|
      if @chapter.raise_order(params[:scale]&.scale)
        format.html { redirect_to chapters_url, notice: 'Chapter was successfully raised order.' }
        format.json { render :show, status: :ok, location: @chapter }
      else
        format.html { redirect_to chapters_url, notice: 'Chapter was failed raised order. Already did you?' }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1/lower_order
  # PATCH/PUT /chapters/1/lower_order.json
  def lower_order
    respond_to do |format|
      if @chapter.lower_order(params[:scale]&.scale)
        format.html { redirect_to chapters_url, notice: 'Chapter was successfully lowered order.' }
        format.json { render :show, status: :ok, location: @chapter }
      else
        format.html { redirect_to chapters_url, notice: 'Chapter was failed lowered order. Already did you?' }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to chapters_url, notice: 'Chapter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:title, :author, :description)
    end
end
