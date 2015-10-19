class PannelControlController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @articles = Article.all
  end

  def delete

    if params[:default] != nil
      params[:default].each do |select|
        article = Article.find(select)
        article.destroy
        redirect_to root_path
      end
    end
    redirect_to root_path
  end
end
