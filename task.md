# Task - Containerise the nodejs app

## Steps:
1. Copy the relevant app files
2. Create a Dockerfile as shown

```
# Build this image from the offical node image
FROM node

# Label is used as a reference if you need to know who build the image
LABEL MAINTAINER= email_address

# Working directory set so we do not have to continually reference throughout
WORKDIR usr/src/app

# Copy app files into the container
COPY app/ .

# Install dependencies in the local node_modules folder
RUN npm install

# Expose port 3000
EXPOSE 3000

# Run the command `npm start app.js`
CMD [ "npm","start","app.js;" ]
```
3. Create a new repository on DockerHub

4. Build a new image using the command
```
docker build -t mina100216/eng74-nodejs-app-dockerised .
```
5. Run the container on port 3000
```
docker run -d -p 3000:3000 mina100216/eng74-nodejs-app-dockerised
```
6. Confirm the app is visible on localhost:3000.        
![app](app.png)

## Increment - Containerise the DB
1. Create a Dockerfile for the database. This will need to be in a separate directory due to conflicts associated with naming convention. The Dockerfile is as follows
```
FROM mongo
EXPOSE 27017
COPY mongod.conf.orig /etc/
```
2. Create the mongod.conf.orig file which will be copied into the container. This simply changes the bind-ip of the configuration file from 127.0.0.1 to 0.0.0.0
3. Docker compose will be used to build both containers. Create a docker-compose.yml file. The contents is as follows:
```yml
version: "2"
services:
  app:
    container_name: app
    restart: always
    build: .
    environment:
      DB_HOST: db:27017
    ports:
      - "3000:3000"
    links:
      - db
  db:
    container_name: database
    build: ./db
    ports:
      - "27017:27017"
```
4. Navigate to `localhost:3000/posts` and the following page should be viewed.     
![posts](images/posts.png)
