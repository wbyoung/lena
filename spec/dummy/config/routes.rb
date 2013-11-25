Rails.application.routes.draw do
  mount Lena::Engine => "/lena"
  root to: 'application#index'
  get 'log', to: 'application#log'
  get 'throw', to: 'application#throw'
  get 'throw_callstack', to: 'application#throw_callstack'
end
