# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  root to: "tests#index"

  devise_for  :users,
              path: :gurus,
              path_names: { sign_in: :login, sign_out: :logout },
              controllers: { sessions: 'users/sessions' }

  resources :badges, only: :index

  # resource :feedback, only: %i[new create]
  get "feedback", to: "feedbacks#new"
  post "feedback", to: "feedbacks#create"

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  namespace :admin do
    resources :tests do
      patch :update_inline, on: :member
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end

    resources :gists, only: %i[index show]

    resources :badges
  end
end
# rubocop:enable Metrics/BlockLength
