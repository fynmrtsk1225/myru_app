class Tag < ApplicationRecord
  has_many :picture_tags, dependent: :destroy
  has_many :attached_pictures, through: :picture_tags, source: :picture
end