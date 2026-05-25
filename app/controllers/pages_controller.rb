class PagesController < ApplicationController

  before_action :authenticate_user!

  def account
  end

  def profile
  end

  def update_profile

    if current_user.update(

      params
      .require(:user)
      .permit(
        :name,
        :introduction,
        :image
      )

    )

      redirect_to(
        account_path,
        notice:
        "プロフィール更新しました"
      )

    else

      render(
        :profile,
        status:
        :unprocessable_entity
      )

    end

  end

end
