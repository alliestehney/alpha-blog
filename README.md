Things I've Learned:

- "Convention over Configuration"
  --> basic MVC layout of rails
  ex: User.rb (model), users_controller.rb (controller), users/show.html.erb (view)
- CRUD actions
  --> create, read, edit/update, destroy
  --> also rerouting (`get 'login', to: 'sessions#new'`)
- Model validations
- Intro level associations
  --> only focused on One to Many
  ex: ONE user can have MANY articles
  ... in the article model, include `belongs_to :user` to show this relationship

          ... in the user model, include `has_many :articles` to show this relationship

          Fun thing: adding `dependent: :destroy` to the `has_many :articles` will delete all articles associated with a user when a user is deleted from the system (SO cool!)

- Intro level authentication
  --> creating and destroying sessions
  --> set up login route to route to sessions#new
  --> add secure password
  --> checking for current_user
  --> created admin users and gave them access to certain things that non-admin users don't have access to

-Styled with bootstrap since the main focus of this site learning rails

Rails Course: https://www.udemy.com/the-complete-ruby-on-rails-developer-course/
