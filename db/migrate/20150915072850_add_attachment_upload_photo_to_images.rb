class AddAttachmentUploadPhotoToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :upload_photo
    end
  end

  def self.down
    remove_attachment :images, :upload_photo
  end
end
