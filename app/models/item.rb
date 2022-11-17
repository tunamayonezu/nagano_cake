class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  enum is_active: { 販売中:true, 販売停止:false }
  
  #################
  #validates
  
  validates :image, presence: true
  validates :genre_id, presence: true
  validates :name, presence: true
  validates :explanation, presence: true
  validates :price, presence: true
  validates :is_active, presence: true
  
  #################
  
  def purchase_price
    (price* 1.1).floor
  end
  
  has_one_attached :image
  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpeg")
      item_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    item_image.variant(resize_to_fill: [width, height], gravity: :center).processed
  end
end
