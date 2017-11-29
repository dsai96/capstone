Rails.application.routes.draw do

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
  get "/courses/from_department" => "courses#from_department", as: "courses/from_department"

  post "/add_course" => "application#add_course_to_list", as: "add_course"
  delete "/delete_course" => "application#delete_added_section", as: "delete_course"

  post "/find_course" => "courses#find_course", as: "find_course"

  get 'home' => 'home#index', as: :home
  get 'signup' => 'students#new', as: :signup

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get    '/logout',  to: 'sessions#destroy', as: :logout
  root 'sessions#new'
end
