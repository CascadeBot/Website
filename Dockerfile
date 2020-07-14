FROM node:lts-alpine

WORKDIR /usr/src/app

# Copy package.json and package-lock.json and run NPM install
# We do this to leverage dockers caching ability
# so we don't have to do this everytime we change the code
COPY package*.json ./

RUN npm install

# Copy the source code to the working directory
COPY . .

# Build both the server and the client
RUN npm run build

FROM nginx
WORKDIR /usr/share/nginx/html
COPY --from=0 /usr/src/app/dist .

