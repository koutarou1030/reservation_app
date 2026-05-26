class RoomsController < ApplicationController

  before_action :authenticate_user!,
                except: [:show, :search]

  def index
    @rooms = current_user.rooms
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create

    @room =
      current_user.rooms.build(
        room_params
      )

    if @room.save

      redirect_to(
        rooms_path,
        notice:
        "施設を登録しました"
      )

    else

      flash.now[:alert] =
        @room.errors.full_messages.join(", ")

      render(
        :new,
        status:
        :unprocessable_entity
      )

    end

  end

  def edit

    @room =
      current_user
      .rooms
      .find(params[:id])

  end

  def update

    @room =
      current_user
      .rooms
      .find(params[:id])

    if @room.update(
      room_params
    )

      redirect_to(
        room_path(@room),
        notice:
        "更新しました"
      )

    else

      render(
        :edit,
        status:
        :unprocessable_entity
      )

    end

  end

  def destroy

    @room =
      current_user
      .rooms
      .find(params[:id])

    @room.destroy

    redirect_to(
      rooms_path,
      notice:
      "削除しました"
    )

  end

  def search

    keyword =
      params[:keyword]

    area =
      params[:area]

    @rooms =
      Room.all

    if keyword.present?

      @rooms =
        @rooms.where(
          "name LIKE ?
           OR introduction LIKE ?",
          "%#{keyword}%",
          "%#{keyword}%"
        )

    end

    if area.present?

      @rooms =
        @rooms.where(
          "address LIKE ?",
          "%#{area}%"
        )

    end

  end

  private

  def room_params

    params
      .require(:room)
      .permit(
        :name,
        :introduction,
        :price,
        :address,
        :image
      )

  end

end
