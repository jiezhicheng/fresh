FROM daocloud.io/nginx

MAINTAINER eastpiger @ Geek Pie Association

EXPOSE 80

RUN apt-get update && apt-get install curl -y && apt-get install gnupg -y

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

COPY nginx.conf /etc/nginx/nginx.conf
COPY fresh.conf /etc/nginx/sites-enabled/fresh.conf

RUN mkdir /logs
RUN mkdir /fresh
COPY . /fresh

RUN npm config set registry http://nexus.daocloud.io/repository/daocloud-npm

RUN cd /fresh \
  && npm install

RUN cd /fresh \
  && npm run build \
  && mv dist/assets/index.html dist/ \
  && rm -rf node_modules
