#project-calendar
Ruby on Rails web application for managing time of employees.

A sample is avaiable on: [heroku link](https://project-calendar.herokuapp.com)

There are two types of users. **Normal users** can sign up, add events to the calendar, give them a description and add them to an existing project. **Admin users** can administer user rights, projects and create reports for specific users, projects and/or a specific time period.

The app uses the [fullcalendar-rails](https://github.com/bokmann/fullcalendar-rails) gem for the jquerry calendar control. The rails version is '4.0.0' and it uses turbolinks.

##Installation

Install all gems from the gemfile
```bash
bundle install
```

Migrate the database
```bash
rake db:migrate
```

Seed the database with the admin accounts
```bash
rake db:seed
```

Run tests
```bash
rake test
```

Run the [WEBrick](http://en.wikipedia.org/wiki/WEBrick) server on `/localhost:3000`
```bash
rails server
```

##Deployment

Application is configured for deployment on [heroku](http://www.heroku.com). Heroku uses [PostgreSQL](http://www.postgresql.org) database and the local server is using the [SQLite](http://www.sqlite.org) embedded database.

Deploying code
```bash
git push heroku master
```

Migrating the database
```bash
heroku run rake db:migrate
```

Checking logs
```bash
heroku logs
```


