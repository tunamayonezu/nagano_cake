class Delivery < ApplicationRecord
  belongs_to :customer

  validates :name, presence: true, length: { minimum: 3 }
  validates :postcode, presence: true, length: { is: 7 }, numericality: {only_integer: true}
  validates :address, presence: true, uniqueness: true, length: { minimum: 10 }
end
