Rails.application.routes.draw do
  root to: proc { [200, {}, ["The Url Shortener API!"]] }

  get '/:short_url', to: 'short_urls#show'

  namespace :api do
    namespace :v1 do
      post 'encode', to: 'short_urls#encode'
      post 'decode', to: 'short_urls#decode'
    end
  end
end
