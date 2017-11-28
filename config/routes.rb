Rails.application.routes.draw do

  resources :students
  resources :majors
  resources :requirements
  resources :semesters
  resources :course_semesters
  resources :courses
  resources :sections
  resources :section_instructors
  resources :instructors

  get "/fetch_courses" => "courses#from_department", as: "fetch_courses"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'home' => 'home#index', as: :home
  get 'signup' => 'students#new', as: :signup

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get    '/logout',  to: 'sessions#destroy', as: :logout
  root 'sessions#new'
end
