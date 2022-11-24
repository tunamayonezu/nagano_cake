class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :deliveries , dependent: :destroy


  def active_for_authentication?
    super && (is_deleted == false)
  end

  #名前をフルネームで記述できるように
  def full_name
    last_name + first_name
  end

#名前かなをフルネームで記述できるように
  def full_name_kana
    last_name_kana + first_name_kana
  end

  has_many :orders ,dependent: :destroy
  has_many :cart_items ,dependent: :destroy


  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/} #カタカナのみ
  validates :first_name_kana, presence: true, format:  { with: /\A[\p{katakana}\p{blank}ー－]+\z/} #カタカナのみ
  validates :postcode, presence: true, length: { is: 7 }, numericality: {only_integer: true} # 「8文字のみ」、整数のみ
  validates :address, presence: true
  validates :phone_number, presence: true, length: { is: 11 }, uniqueness: true, numericality: {only_integer: true} # 「11文字のみ」、重複チェック、整数のみ
end
