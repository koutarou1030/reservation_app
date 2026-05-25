class ReservationsController < ApplicationController

  before_action :authenticate_user!

  def new

    @room =
      Room.find(
        params[:room_id]
      )

    @reservation =
      Reservation.new

  end

  def create

    @room =
      Room.find(
        params[:room_id]
      )

    @reservation =
      current_user
      .reservations
      .build(
        reservation_params
      )

    @reservation.room =
      @room

    if @reservation.save

      redirect_to(
        reservations_path,
        notice:
        "予約しました"
      )

    else

      render(
        :new,
        status:
        :unprocessable_entity
      )

    end

  end

  def index

    @reservations =
      current_user
      .reservations

  end

  private

  def reservation_params

    params
      .require(
        :reservation
      )
      .permit(
        :check_in,
        :check_out,
        :people
      )

  end

end
