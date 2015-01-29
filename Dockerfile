FROM microsoft/aspnet

#install npm in docker image
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs

#install bower and grunt
RUN npm install -g bower
RUN npm install -g grunt-bower-cli
RUN npm install -g grunt
RUN npm install -g grunt-cli
RUN npm install -g grunt-bower-task

COPY . /app
WORKDIR /app
RUN ["kpm","restore"]

EXPOSE 5004
ENTRYPOINT ["k","kestrel"]
