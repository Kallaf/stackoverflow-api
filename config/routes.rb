Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :tags
      resources :users
      resources :questions
      post '/rate_question/:question_id', to: 'question_ratings#rate_question'
      post '/answer_question/:question_id', to: 'answers#answer_question'
      post '/rate_answer/:answer_id', to: 'answer_ratings#rate_answer'
      post '/login', to: 'authentication#login'
      get '/search/:search_text', to: 'search#search'
    end
  end
end
