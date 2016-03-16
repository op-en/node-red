# The first lines of your Dockerfile should always be:
FROM node:0.12
MAINTAINER Leo Fidjeland (leo.fidjeland@gmail.com)

WORKDIR /opt
# install node-red
RUN npm install -g --unsafe-perm \
  node-red \
  # node-red-node-xmpp \ NOTE: Build fails currently.
  node-red-node-web-nodes \
  node-red-contrib-googlechart \
  node-red-contrib-slack \
  node-red-node-suncalc \
  node-red-contrib-influxdb \
  node-red-contrib-freeboard

# We expose the node-red port so that we can access it from the host
EXPOSE 1880

# We fill the node-red installation with some examples so that it is easy to start with node-red
# These are available under [Hamburger]->Import->Library in the node-red console on port 1880
# We add the files to the container, but they are copied to the /root/.node-red folder in the startup script
# This way, we can access the examples even when the volume is mapped to the host
# Solution from: http://stackoverflow.com/questions/27959860/how-to-merge-host-folder-with-container-folder-in-docker
ADD flows example-flows

# We also map the volume so that any changes done in node-red is saved on the host
VOLUME ["/root/.node-red"]

# We use a custom startup script to start the container
# The commands in this script is run after all the volumes have been mounted
# So we can merge folders from the host and the container
ADD startup-script startup-script

# We setup the run command. This is what happens when you run the compiled container.
CMD ["/opt/startup-script"]
