#!/bin/sh
echo "Testing Geoip Detect"
echo "--testing magento.com"
curl -XPOST -H "Content-Type: application/json" -d '{"hostname":"magento.com","path":"/"}' http://localhost:3000/detect/geoip/
echo "--Testing Wordpress.com"
curl -XPOST -H "Content-Type: application/json" -d '{"hostname":"wordpress.com","path":"/"}' http://localhost:3000/detect/geoip/
echo "Testing URL Detect:  Wap + Geoip"
echo "--Testing magento.com"
curl -XPOST -H "Content-Type: application/json" -d '{"hostname":"magento.com","path":"/"}' http://localhost:3000/detect/url/
echo "--Testing google.com"
curl -XPOST -H "Content-Type: application/json" -d '{"hostname":"google.com","path":"/"}' http://localhost:3000/detect/url/
echo "--Testing pi.choukalos.org"
curl -XPOST -H "Content-Type: application/json" -d '{"hostname":"pi.choukalos.org","path":"/"}' http://localhost:3000/detect/url/
echo "--Testing wordpress.com"
curl -XPOST -H "Content-Type: application/json" -d '{"hostname":"wordpress.com","path":"/"}' http://localhost:3000/detect/url/
echo ""
echo "--Testing Batch GEOIP Lookup"
curl -XPOST -H "Content-Type: application/json" -d '{"hostnames": ["magento.com","google.com","wordpress.com","raspberrypi.org"] }' http://localhost:3000/detect/batch/geoip/
echo "--Testing Batch URL Lookup"
curl -XPOST -H "Content-Type: application/json" -d '{"urls": ["magento.com","google.com","stackoverflow.com/questions"]}' http://localhost:3000/detect/batch/url/
echo "Test finished"

