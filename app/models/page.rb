class Page < ActiveRecord::Base
  has_many :images, :dependent => :delete_all
  belongs_to :article
end
