Lena::Engine.routes.draw do
  post 'log', to: 'lena#log', as: :submission
end
