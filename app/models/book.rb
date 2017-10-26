class Book < ApplicationRecord
  has_attached_file :image, styles: { medium: "500x500", little: "900x900>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  scope :first_five, -> { order("rating DESC").first(5) }

  has_many :hist1s
  has_many :comments

  def can_take?(user)
    usertake == user || usertake.nil?
  end

  def can_return?(user)
  	usertake == user # || usertake.present? <- no need
  end

  def can_delete?(user)
    usertake == user || usertake == nil
    
  end


  validates_presence_of :name
  validates_presence_of :author
  validates_presence_of :description
end
