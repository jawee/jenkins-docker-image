FROM jenkins/jenkins:2.334-jdk11

USER root
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y rsync
RUN apt-get install -y wget

# Hugo stuff
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.92.1/hugo_0.92.1_Linux-64bit.deb
RUN dpkg -i hugo_0.92.1_Linux-64bit.deb
RUN rm hugo_0.92.1_Linux-64bit.deb

# Node stuff
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g npm@latest

# Dockerstuff
RUN apt-get install -y\
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/debian \
      $(lsb_release -cs) \
      stable"
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io
RUN usermod -aG docker jenkins
RUN chmod g+s /usr/bin/docker


# dotnet
RUN curl -O https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install -y dotnet-sdk-5.0
RUN apt-get install -y dotnet-sdk-6.0

USER jenkins
