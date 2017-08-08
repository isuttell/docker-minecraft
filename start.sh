#!/bin/bash

#  Make sure this is et
if [ -z "$FORGE_VERSION" ];
then
  echo "Missing FORGE_VERSION environment variable..."
  exit 1;
fi

# Default to 1GB of ram
if [ -z "$JAVA_MEMORY" ];
then
  JAVA_MEMORY=1G
fi

if [ ! -f /data/forge_installer.$FORGE_VERSION.jar ]
then
    echo "Downloading $FORGE_VERSION..."
    curl "http://files.minecraftforge.net/maven/net/minecraftforge/forge/$FORGE_VERSION/forge-$FORGE_VERSION-installer.jar" -o /data/forge_installer.$FORGE_VERSION.jar
fi

# Agree to the EULA
if [ ! -f /data/eula.txt ]
then
    echo "eula=true" > /data/eula.txt
fi

# Move to our working directory
cd /data/;

# Install if we don't see the server jar
if [ ! -f /data/forge-$FORGE_VERSION-universal.jar ]
then
  java -jar /data/forge_installer.$FORGE_VERSION.jar nogui --installServer
fi

# See https://www.spigotmc.org/threads/guide-optimizing-spigot-remove-lag-fix-tps-improve-performance.21726/page-10#post-1055873
java \
  -server \
  -Xms$JAVA_MEMORY \
  -Xmx$JAVA_MEMORY \
  -XX:+UseG1GC \
  -XX:+UnlockExperimentalVMOptions \
  -XX:MaxGCPauseMillis=50 \
  -XX:+DisableExplicitGC \
  -XX:TargetSurvivorRatio=90 \
  -XX:G1NewSizePercent=50 \
  -XX:G1MaxNewSizePercent=80 \
  -XX:InitiatingHeapOccupancyPercent=10 \
  -XX:G1MixedGCLiveThresholdPercent=50 \
  -XX:+AggressiveOpts \
  -XX:+AlwaysPreTouch \
  -XX:+UseLargePagesInMetaspace \
  -jar forge-$FORGE_VERSION-universal.jar nogui
