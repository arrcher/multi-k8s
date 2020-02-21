FROM node:alpine as builder
WORKDIR /app
COPY ./package*.json ./

# provided by caller
ARG proxy_http
ARG HTTP_PROXY=$proxy_http
ARG HTTPS_PROXY=$proxy_http
ARG http_proxy=$proxy_http
ARG https_proxy=$proxy_http

RUN echo -e USED PROXY: $proxy_http

RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
