# frozen_string_literal: true

Rails.application.routes.draw do
  resources :startups
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # apipie

  root to: 'events#index'

  get 'authentications/destroy'
  get '/sitemap', to: 'sitemaps#index', defaults: { format: :xml }

  devise_for :user,
             path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup', edit: 'my/profile/secret' },
             controllers: { omniauth_callbacks: :omniauth_callbacks }

  # Редактирование профиля и аккаунта
  namespace :my do
    resource :profile, controller: 'users', only: %i[show edit update]
    resources :authentications, only: [:destroy]
  end

  namespace :turbo do
    resources :events, only: :index, defaults: { format: :rss }
  end

  # Список пользователей и публичные профили
  resources :users, only: %i[index show]

  # События
  resources :events do
    get :participants, on: :member
    patch :publish, on: :member
    patch :cancel_publication, on: :member
    post :send_publication_notifications, on: :member
  end

  post '/participate_in_event' => 'event_participations#create'
  delete '/cancel_participation' => 'event_participations#destroy'

  # Mailchimp hooks
  constraints token: ENV.fetch('mailchimp_hooks_token') { 'mailchimp_hooks_token' } do
    post '/mailchimp_hooks/:token' => 'mailchimp_hooks#update_subscription'
    get '/mailchimp_hooks/:token' => 'mailchimp_hooks#check'
  end

  # Отписка от email-рассылки
  get '/unsubscribe/:token' => 'subscriptions#unsubscribe', as: :unsubscribe

  # Telegram hooks
  constraints token: ENV.fetch('telegram_bot_token') { 'telegram_bot_token' } do
    post '/telegram_hooks/:token' => 'telegram_hooks#process_bot_request'
  end

  # Tags
  get '/tags/:tag' => 'events#index', as: :tag

  # Let's encrypt cert route
  get '/.well-known/acme-challenge/:id' => 'letsencrypt#approve'

  get ':id' => 'pages#show', as: :page, format: false

  namespace :api do
    namespace :v1 do
      resources :events, only: %i[index show] do
        get '/in/:year(/:month)', to: 'events#index', constraints: { year: /\d{4}/, month: /(0[1-9]|1[012])/ }, on: :collection
      end

      resources :users, only: :show
    end

    namespace :v2 do
      resources :events, only: %i[index show]
      resources :tags, only: %i[index]
    end
  end

  get 'uploads/*any', to: 'errors#image'
end
