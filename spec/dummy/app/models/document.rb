class Document < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  scan_file :attachment
end
