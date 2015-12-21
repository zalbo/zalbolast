class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action  :configure_permitted_parameters, if: :devise_controller?

  def is_close_article #check if there is article open and after delete this
    @articles.each do |article|
    if article.article_close
      puts "article #{article.id } is close"
    else
      puts "article #{article.id} destroy..."
        article.destroy
      end
    end
  end

  def default_photo_exist(article)
    if article.default_photo != nil
      @default_photo = Image.find(article.default_photo).upload_photo.url(:original)
    else
      @default_photo = "/images/logo-02(2).svg"
    end
  end

  def is_not_clone(i , array )
    array.each do |element|
      if element.id == i.id
        return false
      end
    end
    return true
  end

  def ciaone
    binding.pry
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password , :avatar ) }
  end
end
