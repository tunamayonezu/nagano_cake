class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :deliveries , dependent: :destroy

#名前をフルネームで記述できるように
  def full_name
    last_name + first_name
  end
#名前かなをフルネームで記述できるように
  def full_name_kana
    last_name_kana + first_name_kana
  end

end
