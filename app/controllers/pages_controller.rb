class PagesController < ApplicationController
  before_action :set_page, only: [ :show , :edit, :update, :destroy]
  before_action :set_article, only: [ :index, :show , :edit, :update, :destroy]
  protect_from_forgery except: :set_photo

  def set_photo
    @article = Article.find(params[:id])
    @article.update(:default_photo => params[:default])
    redirect_to "/"
  end

  def default_photo
    @article = Article.find(params[:id])
    @images = []
    @article.pages.each do |page|
      if page.images != []
        page.images.each do |image|
          @images << image
        end
      end
    end
  end

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
     @images = @page.images
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.create(page_params)
    if @page.save
      @article  =  Article.find(@page.article_id)
      if params[:photos]
        params[:photos].each { |image|
          @page.images.create(upload_photo: image , article_id: params[:page][:article_id])
        }
      end
      if params[:commit] == "Close Article"
        @article.update(:article_close => true)
        redirect_to "/pages/default_photo/?id=#{@article.id}"
      elsif params[:commit] == "Create other page"
        @article.update(:article_close => false)
        redirect_to "/articles/#{@article.id}/pages/new/?id=#{@article.id}"
      end
    end
  end



  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(@page.article_id)
    end

    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title, :content , :article_id )
    end
end
