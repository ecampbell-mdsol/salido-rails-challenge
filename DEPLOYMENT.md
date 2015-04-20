# Installation Guide

## Prerequisites

Ensure your computer is setup properly.  The following should be installed:

* RVM
* Ruby 2.2.0
* Rails
* Git
* Homebrew
* MySql

If you are using a Mac, you can consult this [tutorial](http://railsapps.github.io/installrubyonrails-mac.html) for most of these.  Instructions for MySql can be found [here](http://dev.mysql.com/downloads/mysql/).

## Rails Application Installation

1. Clone the repo into a directory in your workspace folder.
1. Execute `cd salido-rails-challenge`.
1. Update gem patches by executing `bundle update`.
1. Setup the database by executing `rake db:setup`.

### Special Instructions for Importing Data from ABC Wine Distributors.

You need to obtain an API key for ABC Wine Distributors to access their catalog via their API.  You can register for an account at [https://api.wine.com](https://api.wine.com).

This key should *not* be committed to the repo.  There are several solutions to the general problem of keeping private data private.  This project employs the Figaro gem to do so.  It relies on storing private data in a file `config/application.yml` that is ignored by the project's `.gitignore` file.  When the Rails server is started, the data in this file will be loaded into environment variables that can be accessed by the application.

Create this file with the following single line of YAML:

```yaml
wine_api_key: 'YOUR_API_KEY'
```

where `YOUR_API_KEY` is replaced with the actual key you got after registering with ABC WD.

Now execute `rake abc_wine:load` to import all the ABC WD product catalog.  (This will take a while - close to 800,000 products will be stored in your local DB.)

### Testing the Installation

1. `rails_best_practices` to execute the static analysis tools.
1. `brakeman` to execute the security tests.
1. `rspec` to execute the unit tests (almost 100% code coverage).
1. `rail s` to start an instance of the Rails sever locally on port 3000.
1.  browse to `http://localhost:3000` to land on the product index page.