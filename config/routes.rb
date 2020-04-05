Rails.application.routes.draw do
  get 'categories/index'
  get 'recommends/index'
  get 'news/index'
  get 'favs/create'
  get 'posts/show'
  get 'users/new'
  get 'sessions/new'
  get 'homes/main'
  root to: "homes#main"


  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get  '/posts/:id', to: 'posts#show'

  get  'fav/:id', to: 'favs#create'
  get  'fav', to: 'favs#index'
  get  'news', to: 'news#index'
  get  'recommend', to: 'recommends#index'
  get  'category/:id', to: 'categories#show'






  get '/signup',  to: 'users#new'

  resources :users


end
