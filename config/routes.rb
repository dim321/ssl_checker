Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'

  mount API => '/'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == 'user' && password == 'password'
  end
    mount Sidekiq::Web => '/sidekiq'


end
