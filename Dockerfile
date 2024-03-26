# Stage 1
FROM node:18-alpine as builder
WORKDIR /home/project
COPY ./package.json .
RUN yarn
COPY . .
RUN yarn global add vite && vite build
# Stage 2
FROM nginx:1.25 as Final
WORKDIR /usr/share/nginx/html
# COPY --from=builder /home/project/dist/* . // this was not working, copy of the assets folder had a issue
COPY --from=builder /home/project/dist ./