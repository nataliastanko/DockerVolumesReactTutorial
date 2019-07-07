# 2 different sections

# 1. Build phase

# tag (create id) alpine with the name "builder"
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install

# copy source code
COPY . .

# /app/build folder
RUN npm run build

# 2. Run phase

FROM nginx

# EXPOSE is for AWS Elastic Beanstalk
# port mapped for incoming traffic
EXPOSE 80

# copy from  the "builder" phase
# from doc https://hub.docker.com/_/nginx
# COPY static-html-directory /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html 
