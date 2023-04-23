FROM node:20.0-alpine3.17 as base

USER node

RUN mkdir /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.24.0-alpine3.17 as prod

COPY --from=base /home/node/app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]