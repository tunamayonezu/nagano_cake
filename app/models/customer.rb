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

end
