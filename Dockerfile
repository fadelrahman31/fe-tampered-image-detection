#Build stage
FROM node:12 as build-stage

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

#Bundle app from source
COPY . . 

#Build static app
RUN npm run generate

#production stage
FROM nginx:stable-alpine as production-stage

#Copy to nginx directory at nginx container
COPY --from=build-stage /app/dist /usr/share/nginx/html

#Epxose network interface
EXPOSE 80
#Run nginx
CMD ["nginx", "-g", "daemon off;"]




