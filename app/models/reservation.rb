class Reservation < ApplicationRecord

  belongs_to :user

  belongs_to :room

  validates :check_in,
            presence: true

  validates :check_out,
            presence: true

  validates :people,
            numericality: {
              greater_than: 0
            }

  validate :date_check

  before_save :calculate_total

  def days

    (
      check_out -
      check_in
    ).to_i

  end

  def calculate_total

    self.total_price =
      room.price *
      people *
      days

  end

  private

  def date_check

    return if check_in.blank? ||
              check_out.blank?

    if check_in < Date.today

      errors.add(
        :check_in,
        "は今日以降です"
      )

    end

    if check_out <= check_in

      errors.add(
        :check_out,
        "はチェックイン後です"
      )

    end

  end

end
