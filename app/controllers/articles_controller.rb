require 'articles_helper'

class ArticlesController < ApplicationController
  before_action :authenticate_admin , only: [:new , :update, :destroy]
  before_action :authenticate_user!, only: [:new , :update, :destroy]
  before_action :set_article, only: [:show , :update ]


  def filtered

    @filtered_articles = []
    Article.all.each do |article|
      pages = article.pages
      if params[:search] == nil
        if params[:param1] == article.category
          @filtered_articles << article
        end
      else
        keys_search = params[:search].upcase.split

        keys_search.each do |key|
          #search in article title
          if article.title.upcase.include? key
            if is_not_clone(article , @filtered_articles)
              @filtered_articles << article
            end
          end
          #search  in pages
          pages.each do |page|
            if page.title.upcase.include? key
              if is_not_clone(article , @filtered_articles)
                @filtered_articles << article
              end
            elsif page.content.upcase.include? key
              if is_not_clone(article , @filtered_articles)
                @filtered_articles << article
              end
            end
          end
        end
      end
    end
    @filtered_articles = @filtered_articles.sort_by &:updated_at
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

    redirect_to "/"
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
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
        format.html { redirect_to "/", notice: 'Article was successfully updated.' }
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
    @article = Article.find(params[:article_id])
    puts "#{@article.title} destroy..."
    @article.destroy
    redirect_to "/"
  end

  private

    def authenticate_admin
      if current_user.try(:admin?)
        #nothing
      else
        redirect_to "/", :alert => 'Please Login with Admin.'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :category, :tag , :default_photo )
    end
end
