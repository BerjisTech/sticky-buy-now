Rails.application.routes.draw do
  resources :users
  resources :oversee
  resources :shop
  get   '/uninstallapp',   to: 'bar#uninstallapp'  
  post   '/uninstallapp',   to: 'bar#uninstallapp'
  get   '/bar/delete',   to: 'bar#delete'  
  post   '/bar/delete',   to: 'bar#delete' 
  get   '/bar/redact_customers',   to: 'bar#redact_customers'  
  post   '/bar/redact_customers',   to: 'bar#redact_customers'
  get   '/bar/data_request',   to: 'bar#data_request'  
  post   '/bar/data_request',   to: 'bar#data_request'   
  get    '/installapp',   to: 'shop#installapp'      
  get    '/ologin',   to: 'sessions#new'
  post   '/ologin',   to: 'sessions#create'
  delete '/ologout',  to: 'sessions#destroy'
  get    '/loginasuser/:id',  to: 'oversee#login_as', as: 'loginasuser'
  get    '/install-uninstall-report', to: 'oversee#install_uninstall_report', as: 'install_uninstall_report'
  get    '/other-reports', to: 'oversee#other_reports', as: 'other_reports'
  resources :recurring_application_charges
  resources :bar
  get "/sticky-buy-now-button.js", to: 'widgetapp#javascript'
  get "/sticky-buy-now-button.css", to: 'widgetapp#css'

  root :to => 'shop#edit'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
