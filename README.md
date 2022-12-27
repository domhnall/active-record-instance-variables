## ActiveRecord instance variables

This repo contains a simple Rails blog application to demonstrate the
technique of using an instance variable within a Rails ActiveRecord model.
This technique is discussed in the following blog post:

https://www.vector-logic.com/blog/posts/leverage-regular-instance-variables-on-rails-activerecord-models

In this blog post we examine how an ordinary instance variable can be
added to your Rails models, quite distinct from the persisted
attributes that are synonymous with ActiveRecord. We also discuss a
couple of situations where these instance variables can help you out.


## Set up the project

```
  > git pull
  > bundle install
  > bundle exec rake db:drop && bundle exec rake db:migrate && bundle exec rake db:seed
```


## Run the tests

```
  > bundle exec rake
```

