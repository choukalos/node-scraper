FROM hypriot/rpi-node:4.7.2
MAINTAINER Chuck Choukalos <choukalos@yahoo.com>

# Setup application step
RUN     apt-get update          && \
        apt-get install -y wget && \
        wget https://github.com/fg2it/phantomjs-on-raspberry/releases/download/v2.1.1-wheezy-jessie-armv6/phantomjs_2.1.1_armhf.deb && \
        dpkg -i phantomjs_2.1.1_armhf.deb && \
        mkdir /var/www /var/www/html 
COPY    / /var/www/html
WORKDIR /var/www/html
# Build application step
RUN     npm install

# Expose port 3000
EXPOSE  3000

# Run default command
CMD ["npm","start"]
