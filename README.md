## Docker Volumes React Tutorial

#### Project Development Workflow

## Step 1.

### Install Node.js locally

Run

    node -v

to check if you have it installed.

If ```command not found``` download and install [Node.js](https://nodejs.org/en/download/), then restart your terminal.

### React project generation

    npm install -g create-react-app
    create-react-app appname
    cd appname
    npm run start    # dev only
    npm run test     # run tests
    npm run build    # create build dir, for prod env

### Wrap project into container and build an image from a Dockerfile

Build in development mode

    docker build -f Dockerfile.dev .

Don't worry if warnings displayed.

You should be able to see ```Successfully built someID``` displayed.

## Step 2.

### Start a container

Run

    docker run -p 3000:3000 someID

and go to [localhost:3000](http://localhost:3000/).

## Step 3.

### Use Docker Volumes

Delete ```node_modules``` and  ```build``` dir locally.

#### Get changes to reflected inside of a container

Rebuild the image - repeat steps 1. and 2.

or

Abandon approach of stright copy in Dockerfile - adjust the docker start run command using volumes.

**Volumes set references to local machine and gives us access to files.**
```-v``` sets (bookmarks) a volume.

##### 1. Put a bookmark on the node_modules volumes.

```-v``` with the colon ```:``` syntax means we want to map up a folder inside of the container to a folder outside the container.

##### 2. Map pwd into containder WORKDIR folder.

```-v``` with no colon means do not map against anything. We want to be this a placeholder for the folder inside the container.
    
##### 3. Use ```node_modules``` from a container and you are ready to work on the project live!

Run

    docker run -p 3000:3000 -v /app/node_modules -v $(pwd):/app someID

Which basically means: map everything from ```pwd``` on local machine to ```/app``` inside the container, but do not map (do not overwrite) ```/app/node_modules``` and use ```/app/node_modules``` from a cached container.

```()``` can be replaced with ```{}``` in some cases:

    docker run -p 3000:3000 -v /app/node_modules -v ${pwd}:/app someID

Now every change made in .js app files will be visible instantly on [localhost:3000](http://localhost:3000/) :)
Auto reload is possible here via react server. Normally you would have to refresh the page to see some changes.

## Step 4.

### Use Docker Compose to simplify

Create ```docker-compose.yml```.

Run

    docker-compose up

## Step 5.

### Running tests

Run

    docker build -f Dockerfile.dev .

Take imageID from ```Successfully built imageID``` and run tests

    docker run imageID npm run tests

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

    docker exec -it imageID npm run test

or

#### Use Docker Volumes

Create a second service in ```docker-compose.yml``` and run

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

## Step 7. 

### Running with Nginx server, production ready.

Create new Dockerfile file (for prod).
Use nginx image instead of node:alpine in the container. Build 2 different base images. Build a docker file with multi-step build process.
2 different blocks of configuration: 

1. Build phase
   1. use node:alpine
   2. copy files
   3. install deps
   4. run ```npm run build```
2. Run phase (2nd image)
   1. use nginx
   2. copy over the result of ```npm run build``` (1.III)
   3. start nginx

Run

    docker build .

Copy ID of successfully built container.
Map port 8080 on our machine to 80 inside the container. 80 is default nginx port.

Run 

    docker run -p 8080:80 ID

Go to [localhost:8080](http://localhost:8080/)

***

***

***

* Based on [udemy course](https://www.udemy.com/docker-and-kubernetes-the-complete-guide/).
