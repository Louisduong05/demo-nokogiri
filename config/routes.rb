Rails.application.routes.draw do
  root 'parallels#parallelrate'

  get '/bdcrate' => 'bdc#bdcrate'

  resources :parallels, only: [:create] 
end
