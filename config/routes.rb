Rails.application.routes.draw do
  resources :lancamentos
  resources :categoria
  resources :pessoas
  devise_for :users
  
  resources :relatorios do
    collection do
      post :gerar_relatorio
    end
  end
  
  root to: "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
