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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
