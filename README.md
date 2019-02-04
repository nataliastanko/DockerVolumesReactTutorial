## Docker Workflow React Tutorial

#### Project Development Workflow

## Step 1.

### Build an image from a Dockerfile

Build in development mode

    docker build -f Dockerfile.dev .

Don't worry if warnings displayed.

You should be able to see ```Successfully built someID``` displayed.

## Step 2.

### Start a container

Run

    docker run -p 3000:3000 someID

and go to [localhost:3000](http://localhost:3000/)

***

***

***

* Based on [udemy course](https://www.udemy.com/docker-and-kubernetes-the-complete-guide/).
