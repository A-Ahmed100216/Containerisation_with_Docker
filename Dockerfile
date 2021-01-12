FROM node
LABEL MAINTAINER=email
WORKDIR usr/src/app
COPY app/ .
RUN npm install
EXPOSE 3000
CMD [ "npm","start","app.js;" ]
