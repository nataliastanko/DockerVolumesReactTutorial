## Docker Volumes React Tutorial

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

## Step 3.

### Get changes to reflected inside of a container

Rebuild the image - repeat steps 1. and 2.

or

Abandon approach of stright copy in Dockerfile - adjust the docker start run command, using volumes.

Volumes set references to local machine and gives us access to folders. ```-v``` sets a volume.

#### 1. Put a bookmark on the node volumes.

```-v``` with colon ```:``` syntax means we want to map up a folder inside of the container to a folder outside the container.

#### 2. Map pwd into workdir folder.

```-v``` with no colon means do not map against anything. We want to be this a placeholder for the folder inside the container.
    
#### 3. Run

    docker run -p 3000:3000 -v /app/node_modules -v $(pwd):/app someID

```()``` can be replaced with ```{}``` in some cases:

    docker run -p 3000:3000 -v /app/node_modules -v ${pwd}:/app someID

Now every change made in .js app files will be visible instantly on [localhost:3000](http://localhost:3000/).
Auto reload is possible here via react server. Normally you would have to refresh the page to see some changes.

***

***

***

* Based on [udemy course](https://www.udemy.com/docker-and-kubernetes-the-complete-guide/).
