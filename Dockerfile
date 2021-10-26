FROM node:alpine as builder
WORKDIR '/app' 
COPY package.json ./
RUN npm install 
COPY . .
RUN yarn build

# /app/build <- contains the built files

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# the nginx image already has the start command built-in

