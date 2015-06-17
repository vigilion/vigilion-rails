class CarrierwaveDocument < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  scan_file :attachment, integration: :local
end
