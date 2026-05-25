class User < ApplicationRecord

  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable
  )

  has_one_attached :image

  has_many :rooms,
           dependent: :destroy

  has_many :reservations,
           dependent: :destroy

end
