Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace 'api' do
    namespace 'v1' do
      resources :products
      resources :stores
      resources :stock_items, only: [:create, :index, :show] do
        member do
          put 'add_items', to: 'stock_items#add_items'
          put 'remove_items', to: 'stock_items#remove_items'
        end
      end
    end
  end
end
