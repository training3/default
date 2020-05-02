FROM node:6.14.2
EXPOSE 8080
WORKDIR /data/myApp
COPY server.js .
CMD [ "node", "server.js" ]
