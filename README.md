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

## Notes

### Containerization

The first stage in CI/CD is containerization, and that
means creating a Dockerfile. Specifically for this project, I'll
be making a multi-stage Dockerfile.

#### Stage 1

The first stage of the Dockerfile will be for just creating a base
build of the project by downloading all the dependencies using any
base image.

#### Stage 2

In stage 2, you'd use a distroless image as your base image, which
helps with stuff like security and reduced image size. This stage
will take the binary created in stage 1, expose the port, and run
the app.
