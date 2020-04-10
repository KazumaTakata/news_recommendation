Rails.application.routes.draw do
  get 'mypages/index'
  get 'searchs/index'
  get 'rankings/index'
  get 'comments/create'
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
  get  '/mypage', to: 'mypages#index'
  get  '/mypage/edit', to: 'mypages#edit'
  put  '/mypage', to: 'mypages#update'



  post '/posts/:id/comments', to: 'comments#create'

  get  'fav/:id', to: 'favs#create'
  get  'fav', to: 'favs#index'
  get  'news', to: 'news#index'
  get  'ranking', to: 'rankings#index'
  get  'recommend', to: 'recommends#index'
  get  'category/:id', to: 'categories#show'

  get '/signup',  to: 'users#new'
  get '/search', to: 'searchs#index'

  resources :users


end
