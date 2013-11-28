Lena::Engine.routes.draw do
  match 'log', to: 'lena#log', via: [:get, :post], as: :submission
end
