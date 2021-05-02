FROM jenkins/jenkins:2.290

USER root
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y rsync

# Hugo stuff
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.83.0/hugo_0.83.0_Linux-64bit.deb 
RUN dpkg -i hugo_0.83.0_Linux-64bit.deb
RUN rm hugo_0.83.0_Linux-64bit.deb

# Node stuff
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

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

USER jenkins
