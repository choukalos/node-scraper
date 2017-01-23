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
echo "Test finished"
