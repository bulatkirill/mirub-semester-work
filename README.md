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

1. Run tests = **rspec**

1. Deploy the application on local machine= **rails server -b 127.0.0.1 -p 3000 -e development**

1. Import the collection for postman and run default execution to see default workflow = **https://www.getpostman.com/collections/27d4a8695955113594ec**

Description of the default workflow of the application:

* Application works as the business logic service for application TabBuddy.
* TabBuddy helps a user to ogranize his browser tabs across all browsers and devices.
* Main entities:
    * Device - represents one device of the user
    * Browser - represents registered devices to synchronize with on Device. Device can have have 0..* Browsers.
    * Session - represents a current session in the browser. One Browser can have 0..* saved sessions.
    * Tab - represents one tab in a browser. Browser can have 0..* Tabs.
* Usage of API is secured. Token-based authentication is used. JWT technology is used.
* To register a new API client POST /users have to be done with email and password.
* Authentication is done via POST /authenticate with email and password form params.
* Obtained token from authentication has to be use to authorize all consequent requests to API. Authorization is done via Authorization HTTP header
* Example of default workflow is provided in Postman collection, which does next steps:
    * Register of a new user
    * Authenticate and obtain an api token
    * Create a device
    * Create second device
    * Get all devices
    * Create a browser for device
    * Get a browser for a device
    * Delete a browser
    * Get browsers for a device
    * Create a browser for a device
    * Create a session for a browser
    * Create a tab for a session
    * Get tabs for a session 
    