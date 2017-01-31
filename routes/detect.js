// Route for detecting site software and gathering site info
// example curl -XPOST -H "Content-Type: application/json" -d '{"hostname":"http://google.com","path":"/"}' http://localhost:3000/detect

var express     = require('express');
var router      = express.Router();
var detectcode  = require('../lib/detect');

/* POST lookup */
router.post('/url',function(req,res,next) {
   detectcode.UrlDetect(req.body.hostname,req.body.path,function(err,rc) {
     console.log("Post to Detect Route:");
//     res.setHeader('Content-Type','application/json');
     res.end(JSON.stringify(rc),null,3);
   });
});

router.post('/geoip',function(req,res,next) {
	detectcode.GeoipDetect(req.body.hostname,function(err,rc) {
		console.log("Post to Detect Geoip:");
//		res.setHeader('Content-Type','application/json');
		res.end(JSON.stringify(rc),null,3);
	});
});

router.post('/batch/geoip',function(req,res,next){
	detectcode.BatchGeoip(req.body.hostnames,function(err,rc) {
		console.log("Post to Detect Batch Geoip:");
//		res.setHeader('Content-Type','application/json');
		res.end(JSON.stringify(rc),null,3);	
	});
	
});

router.post('/batch/url',function(req,res,next){
	detectcode.BatchUrl(req.body.urls,function(err,rc) {
		console.log("Post to Detect Batch URLs:");
		res.end(JSON.stringify(rc),null,3);	
	});
});

router.post('/batch/magentoversion',function(req,res,next){
	detectcode.BatchVersion(req.body.hostnames,function(err,rc) {
		console.log("Post to Detect Batch Magento Versions:");
		res.end(JSON.stringify(rc),null,3);
	});
});

module.exports = router;
