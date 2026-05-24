# This a simplistic go app for setting up a CI/CD pipeline

The app will just setup a basic http web server

## File structure

Currently, all the static html pages are in the pages/
folder, and main.go has all the necessary HTTP handlers.
Lastly, main_test.go contains the TestMain function
and determines whether the http server is returning
html files or not.

## Building the project

Building the project is pretty simple, all you do
is run `go build -o [name of whatever you want the binary to be] .`.
Remember to include the ".", and then you just run `./[name of binary]`
