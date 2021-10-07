Rails.application.routes.draw do
  resources :question_ratings
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :tags
      resources :users
      resources :questions
      post '/rate_question/:question_id', to: 'question_ratings#rate_question'
      post '/login', to: 'authentication#login'
    end
  end
end
