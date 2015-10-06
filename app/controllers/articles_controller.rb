require 'articles_helper'



class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new , :update, :destroy ]
  before_action :set_article, only: [:show , :edit, :update, :destroy ]


  def category
   @filtered_articles = []
   Article.all.each do |article|
     if params[:param1] == article.category
       @filtered_articles << article
     end
   end
  end
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
    is_close_article
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
      if @article.save
        redirect_to "/articles/#{@article.id}/pages/new/?id=#{@article.id}"
      end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.delete
    respond_to do |format|
      format.html { redirect_to "/" }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :category, :tag , :default_photo )
    end
end
