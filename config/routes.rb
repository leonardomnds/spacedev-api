Rails.application.routes.draw do
  namespace :auth do
    post :sign_in
    post :sign_out
    get :me
    put :update_password
  end

  namespace :api do
    namespace :v1 do
      resources :users
      resources :companies
    end
  end
end
