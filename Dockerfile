#FROM node
#LABEL MAINTAINER=email
#WORKDIR usr/src/app
#COPY app/ .
#RUN npm install
#EXPOSE 3000
#CMD [ "npm","start","app.js;" ]


# Creating microservices for nodejs front end using Docker
FROM node as APP
WORKDIR /usr/src/app
COPY app/ .
RUN npm install
#RUN npm run /usr/src/app/seed.js

# Building a multi stage layer
FROM node:alpine

# This is the magic line
COPY --from=APP /usr/src/app usr/src/app

WORKDIR /usr/src/app

EXPOSE 3000
CMD ["npm", "run", "seed"]
CMD ["node","app.js"]
