Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
  	get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'groups#index'

  resources :groups do
    resources :comments
  end

  resources :users do
    collection do
      post ':id/follow' => 'users#follow', as: :follow
      post ':id/unfollow' => 'users#unfollow', as: :unfollow
    end
  end


end
