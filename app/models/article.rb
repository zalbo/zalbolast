class Article < ActiveRecord::Base
  has_many :pages, :dependent => :destroy
  has_many :images, through: :pages
end
