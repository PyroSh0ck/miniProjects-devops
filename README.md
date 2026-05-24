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

#### Docker commands

The first thing to do is to create the docker image via:
`docker build -t name:v1`. You can replace name w anything.

The next thing is to run that build:
`docker run -p 8080:8080 -it name:v1`.
The p flag is for mapping the port of the container to the machine,
which is mapping port 8080 of the container to port 8080 of the machine.
And the i flag is to make it interactive. Obviously, the t flag is for
the name, like the previous command.

### Kubernetes Cluster

The first step to setting up a Kubernetes cluster is to make sure
you've pushed the Docker image into DockerHub with this cmd:
`docker push [name of docker image]`. Make sure everything is lowercase.

You could configure Kubernetes to use a local image, but it is better
practice to have it pull from an online registry.

You have to write 3 configuration files (at the minimum) here, which are:
deployment.yaml, service.yaml, and ingress.yaml. I talked a lil bit more about
their usage in the files themselves.

Afterward, you have to deploy your cluster, which you could do via AWS EKS.
It does charge you $0.10 per hour so it will cost money. But after setting it up,
you also need something called an Ingress Controller.

#### Ingress Controller

An ingress controller reads the ingress configuration file and then creates a
load balancer. A fun thing to note is that an ingress controller is usually written
in Go. So it'll watch the ingress resource then redirect traffic to a load balancer,
which in this case will be via nginx with an AWS load balancer (specifically a NLB)

### Helm

Now what if, hypothetically, you had multiple Docker images for different stages.
Like you had one for dev, one for prod, one for test, like so:
pyrosh0ck/miniprojects-devops:dev/prod/test/etc.
You wouldn't bother creating a separate K8s manifest folder for each of them,
which is what Helm helps you out with.

#### Chart.yaml

The Chart.yaml file basically just provides metadata about the information regarding
the chart.

#### Templates

Templates contains all your manifest files with the Helm syntax, so you can use
certain config files as a base, and just replace whatever you need to change with
variables.

#### Values.yaml

This contains all the variables that are going to be used to replace any
{{ .Values... }} in any of the kubernetes manifests. Currently, the only
one that this project has used is {{ .Values.image.tag }}, which is currently
"v1".
