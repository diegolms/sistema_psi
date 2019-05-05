Rails.application.routes.draw do
  resources :vencimentos
  resources :caixas
  resources :lancamentos
  resources :categoria
  resources :pessoas
  devise_for :users

  resources :lancamentos do
    get :download_resume
  end

  resources :relatorios do
    collection do
      post :gerar_relatorio
      get :download_pdf
      get :gerar_relatorio
    end
  end

  get "/relatorios/show", to: redirect("/relatorios/new")

  root to: "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
