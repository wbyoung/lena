Lena::Engine.routes.draw do
  match 'js', to: 'lena#js', via: [:get, :post], as: :js_submission
end
