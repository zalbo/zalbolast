class Page < ActiveRecord::Base
  has_many :images, :dependent => :destroy
  belongs_to :article
end
