# TandaPings
Solution to tanda pings problem, written in ruby using sinatra

#Requirements
- A SQL based database (I used postgres)
- Ruby + gems located in ./Gemfile (or run 'bundle install')
#Usage
- Create a new database
- Configure the app with your database settings in ./config/environments.rb 
- run 'bundle install' from ./ if you do not have the required gems
- run 'rake db:create' from ./ to create a db connection
- run 'rake db:migrate' from ./ to create the db schema
- run 'app.rb' from ./
- use the API at localhost:4567
#Tests
- run 'pings.rb' while app.rb is running
