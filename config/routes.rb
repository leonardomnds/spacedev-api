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
      resources :client_groups
      resources :clients
      resources :instruments
      resources :calibrations

      namespace :dashboard do
        get :active_clients
        get :active_instruments
        get :expired_calibrations
        get :calibrations_to_expire
        get :client_number_evolution
        get :instrument_number_evolution
      end
    end
  end
end
