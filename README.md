Node Based Webscraper REST API service
--------------------------------------

This is a nodejs express based app that provides a variety of useful services to scrape websites.  This git repo is setup to also create raspberrypi docker images so this service can easily run on a docker swarm of raspberry pi's.

Services available:
* POST http://SERVERROOTURL:3000/detect/geoip/ PAYLOAD: { "hostname":"HOSTNAME" } ; returns ip & geoip location 
* POST http://SERVERROOTURL:3000/detect/url/   PAYLOAD: { "hostname":"HOSTNAME","path":"URLPATH"} ; returns geoip and wappalyzer 

Docker / build image
make

Docker / deploy image on swarm
docker service create \
   --name webscrape \
   --publish 3000:3000 \
   choukalos/rpi-node-scrapper
   


