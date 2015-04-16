# Deployment Instructions

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
1. Create the database by executing `rake db:create`.
1. Migrate by executing `rake db:migrate`.

## Testing the Installation

1. Execute `rake -T` to view a list of Rake tasks.
1. Run the unit tests by executing `rspec`.
1. Start an instance of the Rails sever locally on port 3000 by executing `rails s`.  At this point, you can make an API call to the server and get a JSON response with Curl (for example: `curl http::/localhost:3000/products.json`), and/or browse to `http://localhost:3000`.
