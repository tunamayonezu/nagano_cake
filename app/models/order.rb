class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_items, dependent: :destroy
    has_many :items, through: :order_items
    
    enum payment_method: {クレジットカード:0, 銀行振込:1}
    enum status: { 入金待ち:0, 入金確認:1, 制作中:2, 発送準備中:3, 発送済み:4 }
    
  #################
  #validates
  
  validates :postcode, presence: true
  validates :address, presence: true
  validates :name, presence: true
  
  #################
  
  private
  
  def delivery_full
      self.postcode + " " + self.address + " " + self.name
  end
  
end