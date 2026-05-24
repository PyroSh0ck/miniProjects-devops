# This is the newest version I could find from the docker container registry
# Since this is a multi-stage docker file, you have to write an alias for the
# first stage. In this case, the alias is base
FROM golang:1.26 as base

# Just tell docker to run any of its commands in this directory
# You can pretty much call it anything afaik
WORKDIR /docker

# From now on, all the commands here will be executed in the work directory
# We have to copy the go.mod since this file contains all the dependencies
# that we'll have to install. If someone adds dependencies in the future,
# we want to make sure the application will still run correctly, so we 
# have to copy the go.mod file and run it, to install all dependencies.
COPY go.mod .
RUN go mod download


# Now we just have to get the source files for the entire project
# into the working directory for docker:
COPY . .

# Lastly, we just have to build the binary
RUN go build -o main .

# Now we could do something like this here:
# EXPOSE 8080
# CMD("./main")
# And be done, however we want to use two stages
# so that we can make it distroless, which will
# reduce the size and improve security
