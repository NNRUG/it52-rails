Rails.application.routes.draw do
  get 'authentications/destroy'

  devise_for :user,
             path: '', path_names: { sign_in: "login", sign_out: "logout", sign_up: "signup", edit: 'my/profile/secret' },
             controllers: { omniauth_callbacks: :omniauth_callbacks}

  # Редактирование профиля и аккаунта
  namespace :my do
    resource :profile, controller: 'users', only: [:show, :edit, :update,]
    resources :authentications, only: [:destroy]
  end

  # Список пользователей и публичные профили
  resources :users, only: [:index, :show]

  # События
  resources :events do
    patch :publish, on: :member
    patch :cancel_publication, on: :member
  end

  post '/participate_in_event' => 'event_participations#create'
  delete '/cancel_participation' => 'event_participations#destroy'

  constraints token: Figaro.env.mailchimp_hooks_token do
    post "/mailchimp_hooks/:token" => 'mailchimp_hooks#update_subscription'
    get "/mailchimp_hooks/:token" => 'mailchimp_hooks#check'
  end

  root to: redirect('/events')

  get ':id' => 'high_voltage/pages#show', as: :page

  namespace :api do
    namespace :v1 do
      resources :events, only: [:index, :show] do
        get '/in/:year', to: 'events#index', constraints: { year: /\d{4}/ }, on: :collection
      end

      resources :users, only: :show
    end
  end
end
