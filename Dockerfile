FROM node:slim as build
WORKDIR /app
COPY /app /app
RUN npm install
RUN npm run build

# copy the build image to the nginx container
FROM nginx:1.16.0-alpine
COPY --from=build /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d

# Fire up nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
