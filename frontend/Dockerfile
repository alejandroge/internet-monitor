# Stage 1: Build the application
FROM node:20-alpine AS build-stage

WORKDIR /app

# Install dependencies and build the application
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve the application
FROM caddy:2.9.1-alpine AS production-stage

# install curl
RUN apk add --no-cache curl

# Copy built files to nginx web root
COPY --from=build-stage /app/dist /usr/share/caddy

# Copy the Caddyfile for configuration
COPY Caddyfile /etc/caddy/Caddyfile

EXPOSE 80
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
