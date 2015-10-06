class Image < ActiveRecord::Base
  belongs_to :article


  has_attached_file :upload_photo, styles: {medium: "720x720#", thumbnail_medium: "291x291#", thumbnail: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :upload_photo, content_type: /\Aimage\/.*\Z/

  def file
    self.upload_photo
  end

end
