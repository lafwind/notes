### rails notes

* `bundle exec rake routes`

* `rails new sample_app`

* `rails new _4.2.0_ sample_app`

* `bundle install --without production`

* `bundle update`

* `rails server`

* `rails s`

* `rails generate controller Users new`

* `rails destroy controller Users new`

* `rails generate model User name:string email:string`

* `rails destroy model User`

* `bundle exec rake db:migrate`

* `bundle exec rake db:rollback`

* `bundle exec rake db:migrate VERSION=0`

* `rails generate migration add_index_to_users_email`

* `bundle exec rake test`

* `bundle exec rake test:integration`

* `rails console`

* `rails console --sandbox`

* `rails c`

* `validates` 是一个方法名

* `<%= debug(params) if Rails.env.development? %>`

* `gem 'byebug'`, `debugger`

* `params.require(:user).permit(:name, :email, :password, :password_confirmation)`, don't use `params[:user]`

* `user.errors.full_messages`

* `<%= form_for(@user) do |f| %>`

* `form_for(:session, url: login_path)`

* `<%= link_to "Log out", logout_path, method: "delete" %>`

* `session[:user_id] = user.id`

* `session.delete(:user_id)`, ``@current_user = nil`

* `cookies.permanent.signed[:user_id] = user.id`

* `User.find_by(id: cookies.signed[:user_id])`

* `params[:session][:remember_me] == '1' ? remember(user) : forget(user)`
