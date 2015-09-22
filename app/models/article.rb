class Article < ActiveRecord::Base
  has_many :pages, :dependent => :delete_all
  def is_close_article?
    binding.pry
  end
end
