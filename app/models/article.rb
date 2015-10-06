class Article < ActiveRecord::Base
  has_many :pages, :dependent => :delete_all
end
