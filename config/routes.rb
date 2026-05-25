Rails.application.routes.draw do

  devise_for :users

  root "rooms#index"

  get "/account",
      to: "pages#account"

  get "/profile",
      to: "pages#profile"

  patch "/profile",
        to: "pages#update_profile"

  resources :rooms do

    collection do
      get :search
    end

    resources :reservations,
              only: [
                :new,
                :create
              ]

  end

  resources :reservations,
            only: [
              :index
            ]

end
