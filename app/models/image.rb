class Image < ActiveRecord::Base
  belongs_to :article
  has_attached_file :upload_photo, styles: {medium: "720x720#", thumb_medium: "291x291#", thumb_small: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :upload_photo, content_type: /\Aimage\/.*\Z/
end
