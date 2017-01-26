FROM hypriot/rpi-node:4.7.2
MAINTAINER Chuck Choukalos <choukalos@yahoo.com>

#Setup / assume npm dep installed, etc as part of docker build process
COPY / /var/www/html
VOLUME  /var/www/html
WORKDIR /var/www/html
# Expose port 3000
EXPOSE  3000
# Run default command
CMD ["npm","start"]
