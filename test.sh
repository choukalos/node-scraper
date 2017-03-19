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
echo "--Testing Batch Detect Magento Major.Minor version"
curl -XPOST -H "Content-Type: application/json" -d '{"hostnames": ["hellyhanson.com","oliversweeny.com","pumpunderwear.com"]}' http://localhost:3000/detect/batch/magentoversion/ 
echo "--Testing Batch Detect Magento Mode"
curl -XPOST -H "Content-Type: application/json" -d '{"hostnames": ["oliversweeny.com","pumpunderwear.com","mage2.dev","pi.choukalos.org"]}' http://localhost:3000/detect/batch/magentomode/
echo "--Testing Batch performance page load"
curl -XPOST -H "Content-Type: application/json" -d '{"urls":["http://google.com","http://magento.com","http://hellyhanson.com"]}' http://localhost:3000/performance/pageload
echo "Test finished"


