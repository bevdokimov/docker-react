FROM node:alpine as builder
WORKDIR '/app' 
COPY package.json ./
RUN npm install 
COPY . .
RUN yarn build

# /app/build <- contains the built files

FROM nginx

# Usually a documentation instruction among devs.
# BUT in this case AWS Elastic Beanstalk will look into this dockerfile and expose whatever we specify here.
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html
# the nginx image already has the start command built-in

