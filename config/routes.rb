Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # apipie

  get 'authentications/destroy'
  get '/sitemap', to: 'sitemap#index', defaults: { format: :xml }

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
    get :past, on: :collection, action: :index
    get :participants, on: :member
    patch :publish, on: :member
    patch :cancel_publication, on: :member
  end

  post '/participate_in_event' => 'event_participations#create'
  delete '/cancel_participation' => 'event_participations#destroy'

  # Mailchimp hooks
  constraints token: Figaro.env.mailchimp_hooks_token do
    post "/mailchimp_hooks/:token" => 'mailchimp_hooks#update_subscription'
    get "/mailchimp_hooks/:token" => 'mailchimp_hooks#check'
  end

  # Telegram hooks
  constraints token: Figaro.env.telegram_bot_token do
    post "/telegram_hooks/:token" => 'telegram_hooks#process_bot_request'
  end

  # Let's encrypt cert route
  get '/.well-known/acme-challenge/:id' => 'letsencrypt#approve'

  root to: 'events#index'

  get ':id' => 'high_voltage/pages#show', as: :page

  namespace :api do
    namespace :v1 do
      resources :events, only: [:index, :show] do
        get '/in/:year(/:month)', to: 'events#index', constraints: { year: /\d{4}/, month: /(0[1-9]|1[012])/ }, on: :collection
      end

      resources :users, only: :show
    end
  end
end
