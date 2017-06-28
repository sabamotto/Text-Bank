Rails.application.routes.draw do
  resources :attachments
  resources :chapters do
    patch :raise_order, on: :member
    patch :lower_order, on: :member
  end
end
