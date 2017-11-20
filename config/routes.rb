Rails.application.routes.draw do
  get 'home/index'

  resources :students
  resources :majors
  resources :requirements
  resources :semesters
  resources :course_semesters
  resources :courses
  resources :sections
  resources :section_instructors
  resources :student_sections
  resources :instructors
  
  get "/fetch_courses" => "courses#from_department", as: "fetch_courses"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'home' => 'home#index', as: :home

  root :to => 'home#index'
end
