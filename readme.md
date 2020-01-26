# Blog  in rails

simple but enougth

# How to dev
 + Install rails and run bundle install
 + rake db:create
 + rake db:migrate
 + rails s

# How to deploy
+ rake db:create RAILS_ENV=production
+ rake db:migrate RAILS_ENV=production
+ rake assets:precompile RAILS_ENV=production
+ bundle exec puma -C config/puma.rb 


# Feature
 + support markdown and highlight 
 + articles CRUD
 + support upload file into db
 + simple pagination
 + clean code organization
 + don't use too many third-party gem ,so beginner-friendly
  
# Demo
 [http://gongeek.com](http://gongeek.com)
