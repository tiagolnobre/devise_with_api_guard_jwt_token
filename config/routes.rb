# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_scope :user do
        api_guard_routes for: 'users', controller: {
          registration: 'api/v1/users/registrations'
        }
      end

      devise_for :users, path: '',
                         path_names: {
                           registration: 'users'
                         },
                         controllers: {
                           registrations: 'api/v1/users/registrations',
                           confirmations: 'api/v1/users/confirmations'
                         }, skip: [:sessions, :password]
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'user', to: 'users#show'
    end
  end
end
