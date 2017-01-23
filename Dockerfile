FROM hypriot/rpi-node:4.7.2
MAINTAINER Chuck Choukalos <choukalos@yahoo.com>

#Install Deps

#Setup 
COPY / /var/www/html
VOLUME  /var/www/html
WORKDIR /var/www/html
# Ensure NPM dependencies are installed
RUN npm install
# Expose port 3000
EXPOSE  3000
# Run default command
CMD ["npm","start"]
