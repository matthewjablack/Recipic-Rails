class Image < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_base64_uploader :image, ImageUploader




end
