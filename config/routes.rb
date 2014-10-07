TrustyCms::Application.routes.draw do
  namespace :admin do
    resources :sites do
      get :remove, on: member
      post :move_higher, on: member
      post :move_lower, on: member
      put :move_to_top, on: member
      put :move_to_bottom, on: member
    end
  end
end

