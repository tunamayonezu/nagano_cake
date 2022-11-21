class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_items, dependent: :destroy
    has_many :items, through: :order_items

#{}内を英語に変える必要がある
    enum payment_method: {credit_card:0, transfer:1}
    enum status: { payment_waiting:0, payment_confirmation:1, in_production:2, preparing_delivery:3, delivered:4 }

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