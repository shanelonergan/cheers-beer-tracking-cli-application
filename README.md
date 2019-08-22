# Gettin' Drunk: A CRUD ActiveRecord Beer Tracking Application
---
### Authors
  * [Matt Werner](https://github.com/mrwerner392)
  * [Shane Lonergan](https://github.com/shanelonergan)
  * [Josh Nho](https://github.com/Joshikgs)

### Description
  NAMEHERE is a Ruby command line application designed to track beer information and statistics for both consumers and breweries using SQLite3 to store and access users information. First, a new user can create an account as either a brewer or a drinker, filling in their individual information. Drinkers can keep track of their beer consumption history, the contents of their "fridge", see their statistics, as well as view this information for other users. They can also visit breweries to see current menus and stats. Breweries can track their sales history, update their menus, and track statistics for their breweries and the industry as a whole.

### Installation
* From our GitHub page, clone this repository and save it to a local directory.

* In your bash terminal, navigate to the application directory and execute the following command to install the required ruby gems:

  `bundle install`

* To migrate the databases, execute the following command:

  `rake db:migrate`

* To seed data from our sample file, execute:

  `rake db:seed`

  **This command will destroy existing data in the SQLite3 database**

* To launch the application, execute:

  `ruby bin/run.rb`


---
* ##### [Link to Screenshots](https://github.com/deryatanriverdi88/guided-module-one-final-project-dumbo-web-080519/blob/master/SCREENSHOTS.md)
* ##### [Contributor Guidelines](https://github.com/mrwerner392/module-one-final-project-guidelines-dumbo-web-080519/blob/master/CONTRIBUTING.md)
* ##### [License Information](https://github.com/mrwerner392/module-one-final-project-guidelines-dumbo-web-080519/blob/master/LICENSE.md)
