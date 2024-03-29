FROM jenkins/jenkins:2.441-jdk21

USER root
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y rsync
RUN apt-get install -y wget

# Node stuff
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
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
# RUN curl -O https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb
# RUN dpkg -i packages-microsoft-prod.deb
# RUN rm packages-microsoft-prod.deb
# RUN apt-get update
# RUN apt-get install -y dotnet-sdk-5.0
# RUN apt-get install -y dotnet-sdk-6.0

USER jenkins
