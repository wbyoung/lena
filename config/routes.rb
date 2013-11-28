Lena::Engine.routes.draw do
  match 'report', to: 'lena#report', via: [:get, :post]
end
