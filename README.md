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

### Use Docker Volumes

#### Get changes to reflected inside of a container

Rebuild the image - repeat steps 1. and 2.

or

Abandon approach of stright copy in Dockerfile - adjust the docker start run command, using volumes.

Volumes set references to local machine and gives us access to folders. ```-v``` sets a volume.

##### 1. Put a bookmark on the node volumes.

```-v``` with colon ```:``` syntax means we want to map up a folder inside of the container to a folder outside the container.

##### 2. Map pwd into workdir folder.

```-v``` with no colon means do not map against anything. We want to be this a placeholder for the folder inside the container.
    
##### 3. Run

    docker run -p 3000:3000 -v /app/node_modules -v $(pwd):/app someID

```()``` can be replaced with ```{}``` in some cases:

    docker run -p 3000:3000 -v /app/node_modules -v ${pwd}:/app someID

Now every change made in .js app files will be visible instantly on [localhost:3000](http://localhost:3000/).
Auto reload is possible here via react server. Normally you would have to refresh the page to see some changes.

## Step 4.

### Use Docker Compose to simplify

Run

    docker-compose up

## Step 5.

### Running tests

Run

    docker build -f Dockerfile.dev .

Take imageID from ```Successfully built imageID`` and run tests

    docker run cbf73ee5ecb8 npm run test

#### Excercise

Run

    docker run -it imageID npm run test
    
Type ```w``` then ```p``` option and write ```App.test.js``` to excercise some interactivity.

## Step 6.

## Update tests configuration to work live

### Attach to the existing container

Run

    docker-compose up
    docker ps

Copy ID of running react-app container and run

    docker exec -it 69533969f08f npm run test

or

#### Use Docker Volumes

Create a second service and run

    docker-compose up --build

## Downsides

Unfortunately you wont be able to manipulate the tests in interactive mode using ```docker-compose```, you will only get the live and here is the explanation:

Run 

    docker ps

Copy ID of running tests container and attach terminal to stdin, stdout and stderr running:

    docker attach ID

In a new terminal create shell instance inside the open tests container

    docker exec -it ID sh

Run inside the opened container shell command prompt:

    ps

You should be able to see 2 npm processes running. We have access only to the first process while the tests are running by the secondary process. Witch ```docker attach``` accessing the secondary process is not an option. ```docker attach``` can handle only the primary process.

***

***

***

* Based on [udemy course](https://www.udemy.com/docker-and-kubernetes-the-complete-guide/).
