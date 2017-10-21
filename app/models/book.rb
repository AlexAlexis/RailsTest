class Book < ApplicationRecord
  has_attached_file :image, styles: { medium: "500x500", little: "900x900>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  scope :first_five, lambda {order("rating DESC").first(5)}
end
