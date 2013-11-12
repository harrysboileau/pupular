class Qr < ActiveRecord::Base

  attr_accessible :image

  mount_uploader :image, QrUploader

end
