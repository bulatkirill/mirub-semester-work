# Tab Buddy Api

This document contains required steps for deploying an application to local machine.

Make sure you have correct version of ruby and other tools:

* ruby --version >= **2.5.6**

* rails --version >= **6.0.2.1**

* bundle --version >= **2.0.2**

* yarn --version >= **1.19.1**

* rspec --version >= **3.9**

* yardoc --version >= **0.9.20**

Next steps need to be done to run the application:

1. Install yarn dependencies = **yarn install --check-files**

1. Install dependencies = **bundle install**

1. generate documentation = **yardoc .**

1. Execute dev environment migrations = **rails db:migrate RAILS_ENV=development**

1. Execute test environment migrations = **rails db:migrate RAILS_ENV=test**

2. Run tests = **rspec**

3. Deploy the application on local machine= **rails server -b 127.0.0.1 -p 3000 -e development**

4. Import the collection for postman and run default execution to see default workflow = **https://www.getpostman.com/collections/27d4a8695955113594ec**
