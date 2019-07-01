Rails.application.routes.draw do
  resources :sessaos
  resources :clientes
  resources :caixas
  devise_for :users

  resources :relatorios do
    collection do
      post :gerar_relatorio
      get :download_pdf
      get :gerar_relatorio
    end
  end

  get "/relatorios/show", to: redirect("/relatorios/new")

  root to: "clientes#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
