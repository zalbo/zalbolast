class PagesController < ApplicationController
  before_action :set_page, only: [ :show , :edit, :update , :destroy]
  before_action :set_article, only: [  :show , :edit, :update , :destroy]
  protect_from_forgery except: :set_photo

  ##### CHOOSE default PHOTO
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

  #####

  #####RENAME PHOTO

  def rename_photo
    @page = Page.find(params[:id_page])
    @images = @page.images

  end

  def set_name_photo
    @page = Page.find(params[:id_page])
    @images = @page.images
    @article = Article.find(@images[0].article_id)
    @images.each do |ima|
      ima.update(:legend => params[ima.id.to_s])
    end
    if @article.article_close == false
      redirect_to "/articles/#{@article.id}/pages/new/?id=#{@article.id}"
    else
      redirect_to "/pages/default_photo/?id=#{@article.id}"
    end
  end

  ####

  # GET /pages
  # GET /pages.json
  def index
    @article = Article.find(params[:article_id])
    #@pages = @article.pages
    @pages = @article.pages.paginate(:page => params[:page], :per_page => 1)

    default_photo_exist(@article)
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    redirect_to "/"
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

      #if there is video
      urls = []
      params[:page][:url_youtube].each do |key , value|
        if value != ""
            urls << value
        end
      end
      @page.update(:url_youtube => urls)

      #if there is photo
      if params[:photos]
        params[:photos].each { |image|
          @page.images.create(upload_photo: image , article_id: params[:page][:article_id])
        }
      end
      if params[:commit] == "Close Article"
        @article.update(:article_close => true)
        if params[:photos]
          redirect_to "/pages/rename_photo/?id_page=#{@page.id}"
        else
          redirect_to "/"
        end
      elsif params[:commit] == "Create other page"
        @article.update(:article_close => false)
        if params[:photos]
          redirect_to "/pages/rename_photo/?id_page=#{@page.id}"
        else
          redirect_to "/articles/#{@article.id}/pages/new/?id=#{@article.id}"
        end
      end
    end
  end



  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    @page.images.each do |image|
      if params[image.id.to_s] == "to_be_deleted"
        image.destroy
        if @article.default_photo == image.id
          @article.update(:default_photo => nil)
        end
      end
    end

    @page.update(page_params)

    #if there is video

    urls = []
    if params[:exixt_page] != nil
      params[:exixt_page][:url_youtube].each do |key , value|
        if value != ""
          urls << value
        end
      end
    end
    if params[:page][:url_youtube] != nil
      params[:page][:url_youtube].each do |key , value|
        if value != ""
          urls << value
        end
      end
    end
    @page.update(:url_youtube => urls)
        #if there is image
    if params[:photos]
      params[:photos].each { |image|
        @page.images.create(upload_photo: image , article_id: params[:page][:article_id])
      }
      redirect_to "/pages/rename_photo/?id_page=#{@page.id}"
    else
      redirect_to "/"
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.images.each do |image|
      if @article.default_photo == image.id
        @article.update(:default_photo => nil)
      end
    end
    @page.destroy
    redirect_to "/articles/#{@article.id}/pages"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(@page.article_id)
    end

    def set_page
      if params[:id_page] != nil
        @page = Page.find(params[:id_page])
      else
        @page = Page.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title, :content , :article_id )
    end
end
