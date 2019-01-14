Pfm::Application.routes.draw do

	get '/confirmation', :to=>'users#confirmation', :as=>'confirmation'
	post '/socialsignin', :to=>'users#socialsignin', :as=>'socialsignin'
	post '/verification', :to=>'users#verification', :as=>'verification'

  ActiveAdmin.routes(self)
	
  devise_for :admin_users, ActiveAdmin::Devise.config
	 
	devise_for :questions do
		match '/admin/questions/:id/orderup' => 'admin/questions#orderup', :as=>'question_order_up'
		match '/admin/questions/:id/orderdown' => 'admin/questions#orderdown', :as=>'question_order_down'
	end
	
	devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }

  devise_for :users do
    get "/" => "devise/registrations#new", :as => :new_user_registration
  end

  resources :users, :only => [:show, :edit, :update]
  resources :acumen_tests
  resources :tests

  resources :accounts do
    collection do
      get :list
    end
  end

  resources :budgets

  resources :goals do
    collection do
      get :select
    end
  end

  resources :transactions
  resources :trends, :only => :index
	
	
	get '/questions/touchfeely', :to=> 'questions#touchfeely', :as => 'touchfeely'
	get '/questions/hardfacts', :to=> 'questions#hardfacts', :as => 'hardfacts'
	get '/questions/cashflow', :to=> 'questions#cashflow', :as => 'cashflow'
	get '/questions/testresult', :to=> 'questions#testresult', :as => 'testresult'

  resources :questions

  match '/home' => 'pages#show', :id => 'home'
  match '/about' => 'pages#show', :id => 'about'
  match '/how_it_works' => 'pages#show', :id => 'how_it_works'
  match '/faq' => 'pages#show', :id => 'faq'
  match '/terms_of_use' => 'pages#show', :id => 'terms_of_use'
  match '/help_create_account' => 'pages#show', :id => 'help_create_account'
  match '/dashboard' => 'dashboard#show'
  match '/sundry_legal_information' => 'pages#show', :id => 'sundry_legal_information'
  match '/privacy_security_policy' => 'pages#show', :id => 'privacy_security_policy'
  match '/community_policy' => 'pages#show', :id => 'community_policy'
  match '/pricing' => 'pages#show', :id => 'pricing'
  

  resource :contact_us, :only => [:create]
  match '/contact_us' => 'contact_us#new'

  root to: 'pages#home'

end
