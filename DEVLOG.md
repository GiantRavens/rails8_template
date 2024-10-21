# devlog

## Set up application

Confirm have latest ruby and gems. Begin new Rails 8 app:

`rails new rails8_template --css tailwind`

## Understand how to use UUID7 ids (even in sqlite)

Add UUID7 gem in Gemfile

https://github.com/sprql/uuid7-ruby

`gem uuid7`
`bundle update`
`bundle install`

Test that the methods are present in Rails console:

`rails c`
`UUID7.generate`

When generating resources make sure that you have an id/string attribute, then add add UUID7 to models like so:

``` ruby
class YourModel < ApplicationRecord
  before_create :set_uuid

  private

  def set_uuid
    self.id = UUID7.generate if self.id.nil?
  end
end
```

Create a test resource to put it all together:

`rails g scaffold post title:string body:text published:boolean`

Modify the migration file to disable native id key and instead point to the new UUID7 one:

```ruby
class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts, id: false do |t|
      t.string :id, primary_key: true
      t.string :title
      t.text :body
      t.boolean :published
      
      t.timestamps
    end
  end
end
```

Modify app.post.rb:

```ruby
class Post < ApplicationRecord
  before_create :set_uuid
  
  private
  
  def set_uuid
    self.id = UUID7.generate if self.id.nil?
  end
end
``` 

`bin/rails db:migrate`

Posts created in the console properly create UUID7s - though using the scaffold created forms does not as they treat the ID field as a modifiable attribute.

```ruby
  post = Post.new(title: "New Post Title", body: "New Post Content")
  post.save
```

Remove the id fields in the _form partial and it works properly.


## create non-UUID7 pages before testing authentication

We'll create 3 pages, an index which is the application root and an about page that are open to all users whether logged in or not, and finally a welcome page that is only available to logged in users, and is the page users are redirected to after they complete login.

`rails g controller pages index welcome about`
` bin/rails routes`

Then / and /about etc. should all resolve properly.

While we're att it let's set an app-wide Application name that will make template a little DRYer inside the application.rb:

```
def appname
  @appname = "Rails 8 Template Application Name"
end
```

Then in helpers/pages_helper.rb:

```
# helpers/pages_helper.rb
# Pull the application name set in config/application.rb
# Call with appname in page layouts like <%= appname %>
def appname
  @appname = Rails.application.appname
end
```

You can now invoke the appname in erb.

Clean up page templates:

Application Layout at app/views/layouts/application.html.erb:

```
<title><% if content_for?(:page_title) %><%= appname %> | <%= yield(:page_title) %><% else %><%= appname %><% end %></title>
    <% if content_for?(:page_description) %><meta name="description" content="<%= yield(:page_description) %>"/><% end %>
```

Then in individual pages add title and descriptions like:

```
<%= content_for :page_title, 'Home Page' %>
<%= content_for :page_description, 'Home Page' %>
```

## implement Rails-native authentication (instead of devise)

You should be able to set up basic user authentication with simple email reset with a built-in generator:

`rails g authentication`

Then create a user in the console with:

`user = User.new(email: "email address", password: "password")`

Note how it filters the email address and only shows the digest hash of the password. You can then log in with those credentials.

And even test that its working in the console still with:

`user.authenticate("securepassword")`

On success it will show user details - otherwise it fails with 'false'.

- SETUP MAILER (mailgun, etc.? or just mail test gem)
- FINISH LOGIN AND NEW USER PAGES
