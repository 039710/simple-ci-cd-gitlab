FROM node:slim as build
WORKDIR /app
COPY /app /app
RUN npm install
RUN npm run build

FROM nginx
# copy the build image to the nginx container
COPY --from=build /app/build /usr/share/nginx/html
# set up new configuration file
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf