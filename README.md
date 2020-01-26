# Tab Buddy Api

This documents provides you with an information for preparing and deploying your application to run locally step by step.

Make sure you have correct version of ruby and ruby on rails:

* Ruby version >= **2.5.6**

* Rails >= **6.0.2.1**

Next steps need to be done to run the application:

1. Install yarn dependencies = **yarn install --check-files**

1. Execute dev environment migrations = **rails db:migrate RAILS_ENV=development**

1. Execute test environment migrations = **rails db:migrate RAILS_ENV=test**

2. Run tests = **rspec**

3. Deploy the application on local machine= **rails server -b 127.0.0.1 -p 3000 -e development**

4. Import the collection for postman and run default execution to see default workflow = **https://www.getpostman.com/collections/27d4a8695955113594ec**
