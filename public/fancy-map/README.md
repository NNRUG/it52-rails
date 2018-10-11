# Start-Angular-Material
My simple bootstrap project for Angular JS and Material design small projects

This is a mix between:
* [https://github.com/angular/angular-seed](https://github.com/angular/angular-seed)
* [https://github.com/angular/material-start](https://github.com/angular/material-start)

Added some of my helpers, mixed both projects and removed test dependancies as this bootstrapp will mainly be used for small tiny prototypes.


### Install Dependencies

We have two kinds of dependencies in this project: tools and angular framework code.  The tools help
us manage and test the application.

* We get the tools we depend upon via `npm`, the [node package manager][npm].
* We get the angular code via `bower`, a [client-side code package manager][bower].

We have preconfigured `npm` to automatically run `bower` so we can simply do:

```
npm install
```

Behind the scenes this will also call `bower install`.  You should find that you have two new
folders in your project.

* `node_modules` - contains the npm packages for the tools we need
* `app/bower_components` - contains the angular framework files

*Note that the `bower_components` folder would normally be installed in the root folder but
angular-seed changes this location through the `.bowerrc` file.  Putting it in the app folder makes
it easier to serve the files by a webserver.*

### Run the Application

We have preconfigured the project with a simple development web server.  The simplest way to start
this server is:

```
npm start
```

Now browse to the app at `http://localhost:8000/app/index.html`.


## Directory Layout

```
app/                    --> all of the source files for the application
   assets/app.css        --> default stylesheet
   src/           --> all app specific modules
      users/              --> package for user features
      index.html            --> app layout file (the main html template file of the app)
```