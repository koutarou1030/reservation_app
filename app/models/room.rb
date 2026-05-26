class Room < ApplicationRecord

  belongs_to :user

  has_many :reservations,
           dependent: :destroy

  has_one_attached :image

  validates :name,
            presence: true

  validates :introduction,
            presence: true

  validates :price,
            numericality: {
              greater_than: 0
            }

  validates :address,
            presence: true

end
