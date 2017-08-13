# LTS Ubuntu
FROM   ubuntu:14.04
MAINTAINER Isaac Suttell <isaac@isaacsuttell.com>

# Skip interactive prompts
ENV    DEBIAN_FRONTEND noninteractive

# Update
RUN    apt-get --yes update; apt-get --yes upgrade; apt-get --yes install software-properties-common

# Java
RUN    sudo apt-add-repository --yes ppa:webupd8team/java; apt-get --yes update
RUN    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
       echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
       apt-get --yes install curl oracle-java8-installer ; apt-get clean



# Load our scripts
ADD    ./start.sh /start.sh

# Fix all permissions
RUN    chmod +x /start.sh

# Make Minecraft Port available
EXPOSE 25565
EXPOSE 25565/udp

# Create a persistent storage point for the world
VOLUME ["/data"]

# Start the server
CMD    ["./start.sh"]
