Rails.application.routes.draw do

  # get '/blogs', to: 'blogs#index'

  root to: 'tops#index'
  resources :blogs do
    collection do
      post :confirm
    end
  end

  # resources :contacts
  resources :contacts, only: [:new, :create]

  resources :users, only: [:new, :create, :show]

  resources :sessions, only: [:new, :create, :destroy]

  resources :favorites, only: [:create, :destroy]

  # letter_openerのルーティング。ローカルでのメール送信テスト。
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?


end
