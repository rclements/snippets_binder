class Image < ActiveRecord::Base
  has_attached_file :image_file, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
