Mpm-magic
=========

Mpm-magic is an attempt to create a magic the gathering like game in Ruby.

The work in progress can be view on heroku:

http://mpm-magic.herokuapp.com/

[ ![Codeship Status for eltados/mpm-magic](https://codeship.io/projects/968f0260-1207-0132-a2a8-4ec5f4cbfced/status?branch=master)](https://codeship.io/projects/33180)


Running your local copy : 

Install ruby version 2.0.0 using RVM  :  http://rvm.io/rvm/install

```
\curl -sSL https://get.rvm.io | bash

rvm install 2.0.0

rvm use 2.0.0
```

Clone the repo and cd to the repo folder

Install the dependencies 
```
bundle install
```

Start the application
```
thin start
```
Go to http://127.0.0.1:3000/cards

Start the application using default http port
```
rvmsudo thin start -p 80
```

Go to http://127.0.0.1/cards

Profit !


contribute  

 * fork the project
 * add a creature by copying an existing one.
 * make a pull request
 * 
You can also use this command to track the changes on the other forks  :
```
git remote add eltados https://github.com/eltados/mpm-magic.git
git diff eltados/master
```
 
Enjoy
