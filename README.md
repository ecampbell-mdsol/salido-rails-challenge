# README

Consult the [Installation Guide](INSTALLATION.md) to set up the application.  The original challenge instructions can be found [here](CHALLENGE.md).

# What Has Been Done

A rake task is available to import all the data from ABC WD into the application's DB.  It needs to be executed only once.  Consult the installtion instructions linked above.

A user can view the list of products, **create** a new product, and **update** (or delete) an existing product with a web browser.  As the catalog data from ABC WD is fairly large, the list of products is loaded via AJAX one "page" at a time.  The user can speicify different page number/sizes, as well as search and sort parameters via the UI.

You can also make API calls to the application.  Assuming you are using `curl`, and your application is running on `localhost:3000`, you can get the first ten products of the catalog with:

    curl -i http://localhost:3000/products.json

Different page numbers and sizes can be specified.  To get the thrid page of products, with pages being size 20, execute:

    curl -i http://localhost:3000/products.json?start=40&length=20

You can search.  For example:

    curl -i "http://localhost:3000/products.json?search\[value\]=pink"

You can create a new product by doing a POST:

    curl -i -d "product[name]=Goblet&product[year]=1999" http://localhost:3000/products.json

Finally, you can show, delete, or **update** a single product by id.  For example, to change the retail price of the product with ID 123 to $19.99:

    curl -i -X PUT -d "product[price_retail]=19.99" http://localhost:3000/products/123.json

The RSpec unit tests cover all but one line of the application code.  I also employed the Mutant gem to evaluate to evaluate my test suite.  All but a few of the mutants died (this is good!).

# Design Decisions

I elected to used the DataTables jQuery package to supply search/sort/pagination in the UI, and a couple of gems to make integration with Rails easy.  This approach has a number of pros and cons:

* *Pros:*  The data returned by the server for an index API call to the browser is in the form of HTML fragments.  This minimizes the amount of rendering that JS has to perform, and keeps the size of reposnses small.

* *Cons"*  There is quite a bit of "magic" going on.  The application searches/sorts/paginates without any real code being written to perform these functions.  The application is very much dependent on the correctness of the package (and gems).  Also, the API that is exposed to an external consumer is a bit awkward at times.